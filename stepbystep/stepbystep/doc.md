太好了 — 我把 **Solidity 内联汇编（inline assembly / Yul）** 的学习路线整理成一份「逐步进阶」的手册：从最基础的语法、内存/存储/ calldata 操作，到调用/返回/错误处理、常见优化与安全注意点，并配上**可复制的示例代码**和练习题。按步骤学，边看边跑测试最有效。开始吧 🚀

# 第 0 步 —— 为什么学内联汇编（动机）

* 能更精细地控制 EVM 操作（内存、存储、返回值、低级调用）。
* 在“热路径”做极限 gas 优化（数学、数据拷贝、批量操作）。
* 实现一些高层语言不方便直接做的操作：自定义 calldata 解析、最小代理（EIP-1167）、创建字节码、手写低成本循环/复制、处理 return/revert 的原始字节等。

> 但：**内联汇编可读性差、易错且更难审计**。只有在明确需要时才用。

---

# 基础（语法与环境）

* 在 Solidity 中写内联汇编：

```solidity
assembly {
   // EVM 指令/内建函数/let/for/if/...
}
```

* 目前推荐使用 **Yul 风格**（Solidity 会把 assembly 转为 Yul），语法更接近 EVM 操作。
* 注意：在 assembly 中没有 Solidity 的自动检查（比如整数溢出检查、bounds-check）；运算按 256-bit 模 2^256。

---

# 第 1 步 —— 最简单示例：用 assembly 做加法

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssemblyStep0 {
    // 高层写法
    function addHigh(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    // 内联汇编写法
    function addAsm(uint256 a, uint256 b) external pure returns (uint256 res) {
        assembly {
            res := add(a, b) // 用 EVM add 指令
        }
    }
}
```

学点：`add`、`mul`、`sub`、`div`、`mod`、`and`、`or`、`xor` 等 EVM 算术/逻辑指令都可直接用。

---

# 第 2 步 —— 内存（memory）的读写：`mload` / `mstore`

* Solidity 约定：`0x40` 存放 **free memory pointer**（下次可用内存起始地址）。
* `mstore(addr, value)`：把 32 字节写到内存 `addr`。
* `mload(addr)`：从内存 `addr` 读 32 字节。

示例：用 assembly 填充并返回一个字符串（通过 high-level 返回）：

```solidity
pragma solidity ^0.8.19;
contract AssemblyMemory {
    function returnHello() external pure returns (string memory) {
        bytes memory b = new bytes(5);
        assembly {
            // 内存布局：b (pointer) 的第0个 32 bytes 存长度, 第32字节开始是数据
            let dataPtr := add(b, 32) 
            // 写入 32 字节，'hello' 左对齐（高位），因此需要填充
            mstore(dataPtr, 0x68656c6c6f000000000000000000000000000000000000000000000000000000)
        }
        return string(b); // solidity 将把 bytes 编码成 string 返回
    }
}
```

注：构造复杂动态返回时要小心内存布局（length + data）。

---

# 第 3 步 —— 访问 calldata：`calldataload` / `calldatacopy` / `calldatasize`

`calldataload(offset)`：从 calldata 指定偏移读 32 字节（注意 selector 占前 4 字节）。

示例：直接从 calldata 读取两个 uint（跳过 4 字节 selector）并相加：

```solidity
pragma solidity ^0.8.19;
contract AssemblyCalldata {
    // 通过 ABI 调用： func(a:uint256, b:uint256)
    function addFromCalldata() external pure returns (uint256 sum) {
        assembly {
            // calldata 布局：0..3 selector, 4..35 第一参数, 36..67 第二参数
            let a := calldataload(4)
            let b := calldataload(36)
            sum := add(a, b)
        }
    }
}
```

练习：用 `calldatacopy` 把 calldata 拷贝到内存并从内存解析（适合 bytes 参数）。

---

# 第 4 步 —— storage：`sload` / `sstore` 与 mapping slot 计算

* `sload(slot)` / `sstore(slot, value)` 直接操作 storage slot（slot 是 256-bit 索引）。
* mapping 的 slot = `keccak256(abi.encodePacked(key, baseSlot))`（baseSlot 是 mapping 在合约中的槽位 index）。

示例：用 assembly 实现 mapping 的读写（假设 mapping 名为 `balances`）：

```solidity
pragma solidity ^0.8.19;
contract AssemblyStorage {
    mapping(address => uint256) public balances; // balances.slot 可在 assembly 中用 balances.slot

    function setBalAsm(address who, uint256 val) external {
        assembly {
            // 把 key 放到内存 0x0，slot 放到 0x20，然后 keccak256
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            sstore(h, val)
        }
    }

    function getBalAsm(address who) external view returns (uint256 val) {
        assembly {
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            val := sload(h)
        }
    }
}
```

重要：`balances.slot` 是由编译器生成并可在 assembly 中引用（更稳妥比手工猜 slot 好）。

---

# 第 5 步 —— 低级外部调用：`call` / `staticcall` / `delegatecall` 与 returndata

典型模式：把 calldata 从 calldata 区拷贝到内存，然后 `call`，最后处理 `returndatasize` 与 `returndatacopy`，并按需 `return` 或 `revert`。

示例：把 `bytes calldata payload` 转发到目标合约并把返回值原样返回：

```solidity
pragma solidity ^0.8.19;
contract AssemblyCall {
    function forwardCall(address to, bytes calldata payload) external returns (bytes memory) {
        assembly {
            // 在内存中分配空间
            let ptr := mload(0x40)
            // 把 calldata 中的 payload 拷贝到内存 ptr
            calldatacopy(ptr, payload.offset, payload.length)
            // 执行 call(gas, to, value, inMem, inSize, outMem, outSize)
            let success := call(gas(), to, 0, ptr, payload.length, 0, 0)
            let retSz := returndatasize()
            // 用 free memory 存放返回数据
            let rptr := mload(0x40)
            returndatacopy(rptr, 0, retSz)
            switch success
            case 0 { revert(rptr, retSz) }
            default { return(rptr, retSz) }
        }
    }
}
```

要点：

* **必须检查 call 返回值**（`success`），并在失败时把 `returndatacopy` 回传回去（保留 revert 原因）。
* 使用 `delegatecall` 时，注意 `msg.sender`/storage 语义会被改变（委托调用使用宿主合约的 storage）。

---

# 第 6 步 —— 错误/返回字节构造（带 revert reason）

当你想从 assembly 返回一个带字符串理由的 revert（例如 "Not authorized"），需要构造 Error(string) ABI 编码并 `revert`。

示例：

```solidity
function revertWithReason() external pure {
    assembly {
        // error string: "Not authorized"
        let ptr := mload(0x40)
        mstore(ptr, 0x08c379a00000000000000000000000000000000000000000000000000000000) // selector
        mstore(add(ptr, 4+32), 32) // offset to string
        mstore(add(ptr, 4+64), 14) // length
        // store the ascii bytes (left-aligned) — 举例写法，需按实际长度和对齐
        mstore(add(ptr, 4+96), 0x4e6f7420617574686f72697a65640000000000000000000000000000000000)
        revert(ptr, add(4, add(32, add(32, 32)))) // 4(selector)+32(offset)+32(len)+32(data padded)
    }
}
```

（上面演示了如何手工构造 `Error(string)`，实际长度计算要精确。）

---

# 第 7 步 —— 日志（事件）在 assembly 中：`log0..log4`

assembly 支持原始 log 指令（log0\~log4）。这在调试时很有用（可通过链上日志观察变量），但一般用 solidity `emit` 更方便。

示例（把内存一段写成日志）：

```solidity
assembly {
    let ptr := mload(0x40)
    mstore(ptr, 123)
    log1(ptr, 32, 0x123456...) // topic0
}
```

---

# 第 8 步 —— 常见模式与注意事项（安全与陷阱）

1. **没有溢出/下溢保护**：在 assembly 中 `add`/`mul` 都是 wrap-around，自己负责安全检查。
2. **内存管理**：别覆盖 0x40 位置（free memory pointer），在使用后更新 `mstore(0x40, newPtr)`。
3. **storage slot 碰撞**：写原始 storage slot 时保证与高层变量不冲突，或用 interface/slot 常量。
4. **外部调用要 check 返回**；失败时处理 revert 原因（returndatacopy + revert）。
5. **可读性/审计**：尽量把复杂逻辑封装并写单元测试，注释要非常清晰。
6. **调试**：可以在 assembly 中使用 `revert` 返回中间值来“打印”或利用 `log` 指令，或在本地使用 Hardhat 的 trace/console。
7. **Gas**：assembly 去掉了很多高级检查，但不保证默认更快 —— 做微优化前先基准测试（bench）。

---

# 第 9 步 —— 真实例子：用 assembly 做简单 calldata 解码并调用 transferFrom

> 场景：合约函数接受 `(address token, address from, address to, uint256 amount)`，在内部直接用 `calldataload` 读取并执行 `transferFrom(from, to, amount)`（低级 call）。

```solidity
pragma solidity ^0.8.19;

interface IERC20 {
    function transferFrom(address, address, uint256) external returns (bool);
}

contract AssemblyTransferFrom {
    // function transferFromLowLevel(address token, address from, address to, uint256 amount)
    function transferFromLowLevel(bytes calldata data) external {
        // data 要与上面的 ABI 对齐（例如 caller 用 abi.encodeWithSelector(...))
        assembly {
            // 跳过 selector: data starts at calldata offset 4
            let token := calldataload(4)     // offset 4..35
            let from  := calldataload(36)    // offset 36..67
            let to    := calldataload(68)    // offset 68..99
            let amount := calldataload(100)  // offset 100..131

            // 准备 ERC20 transferFrom selector + args 到内存
            let ptr := mload(0x40)
            mstore(ptr, 0x23b872dd00000000000000000000000000000000000000000000000000000000) // transferFrom selector
            mstore(add(ptr,32), from)
            mstore(add(ptr,64), to)
            mstore(add(ptr,96), amount)

            // call token contract
            let success := call(gas(), token, 0, ptr, 4 + 32*3, ptr, 32)
            // 读取返回
            if iszero(success) {
                // 失败：把 revert reason 返回（复制 returndata）
                let s := returndatasize()
                returndatacopy(ptr, 0, s)
                revert(ptr, s)
            }
            // 可选：检查返回是否为 true
            let returned := mload(ptr) // 如果 token 遵循返回 bool 的习惯
            if iszero(returned) { revert(ptr, 0) }
        }
    }
}
```

⚠️ 真实 ERC20 实现不完全一致（有的 token 不返回 bool），需考虑兼容性（`try/catch` 或在 assembly 中接受空返回视为成功等策略）。

---

# 第 10 步 —— 调试与验证（实践）

* 写 unit tests（Hardhat + Waffle/Chai）对比 assembly 与 solidity 版本输出与 gas。
* 使用 `console.log`（Hardhat 的 solidity 插件）在 high-level Solidity 中打印中间值以辅助定位（assembly 内部无法直接 `console.log`）。
* 使用链上回溯（Hardhat trace / Tenderly）观察失败的 opcode。

---

# 练习题（推荐）

1. 用 assembly 写一个函数 `sum(uint256[] calldata arr)`，返回数组和（注意 calldata layout）。
2. 用 assembly 实现 `memcmp`（内存比较两个内存段）。
3. 实现一个低 gas 的 `isWhitelisted(address[] memory list, address x)`：用二分查找（假设传入已排序）。对比高层实现的 gas。
4. 手写 `create2` 部署 minimal proxy（EIP-1167）的字节码并返回地址。
5. 改写某段【你现有的合约】中最热的函数为 assembly，测基准和安全性。

---

# 参考（建议读物/文档）

* Solidity 官方文档中 assembly / Yul 段落（示例很多）。
* EVM opcode 表（理解每条指令 gas 成本）。
* OpenZeppelin 的合约实现（找出哪些地方用 assembly 做优化）。
* 各类 gas benchmark/博客（做优化前先对比）。

---

# 最后：谨慎原则（非常重要）

* 内联汇编能省 gas，但也容易引入安全漏洞（尤其越界、溢出、storage slot 错乱、错误的外部调用处理）。
* 先写高层正确实现并通过测试，再在 hot path 用 assembly 重写并做严格对比测试与审计。
* 变更前写好大量单元测试（尤其重放极端输入与边界情况）。

---


好👌 既然你要用 **Foundry** 来学习和测试内联汇编，我们可以把我上面给你的 10 个步骤做成一个 **Foundry 项目**，包含：

* 一个 `AssemblyTutorial.sol` 合约，里面逐步实现 add/memory/calldata/storage/call/revert 等示例函数。
* 一个 `AssemblyTutorial.t.sol` 测试文件，使用 Foundry 的 `forge-std/Test.sol` 写单元测试。
* 每个步骤一个测试 case，对比高阶 Solidity 写法和 assembly 写法是否一致，并且跑 `forge test --gas-report` 看 gas 差异。

---

## 1. 新建 Foundry 项目

```bash
forge init assembly-tutorial
cd assembly-tutorial
```

---

## 2. 在 `src/AssemblyTutorial.sol` 写合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssemblyTutorial {
    /* ============ Step 1: 基础运算 ============ */
    function addHigh(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function addAsm(uint256 a, uint256 b) external pure returns (uint256 res) {
        assembly {
            res := add(a, b)
        }
    }

    /* ============ Step 2: Memory ============ */
    function helloBytes() external pure returns (string memory) {
        bytes memory b = new bytes(5);
        assembly {
            let dataPtr := add(b, 32)
            mstore(
                dataPtr,
                0x68656c6c6f000000000000000000000000000000000000000000000000000000
            )
        }
        return string(b);
    }

    /* ============ Step 3: Calldata ============ */
    // ABI: addFromCalldata(uint256,uint256)
    function addFromCalldata() external pure returns (uint256 sum) {
        assembly {
            let a := calldataload(4)
            let b := calldataload(36)
            sum := add(a, b)
        }
    }

    /* ============ Step 4: Storage ============ */
    mapping(address => uint256) public balances;

    function setBalAsm(address who, uint256 val) external {
        assembly {
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            sstore(h, val)
        }
    }

    function getBalAsm(address who) external view returns (uint256 val) {
        assembly {
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            val := sload(h)
        }
    }

    /* ============ Step 6: Revert with reason ============ */
    function revertWithReason() external pure {
        assembly {
            let ptr := mload(0x40)
            mstore(
                ptr,
                0x08c379a00000000000000000000000000000000000000000000000000000000
            ) // selector
            mstore(add(ptr, 36), 32) // offset
            mstore(add(ptr, 68), 14) // len
            mstore(
                add(ptr, 100),
                0x4e6f7420617574686f72697a65640000000000000000000000000000000000
            )
            revert(ptr, 132) // 4+32+32+32=100 实际填充到下个32=132
        }
    }
}
```

---

## 3. 在 `test/AssemblyTutorial.t.sol` 写测试

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/AssemblyTutorial.sol";

contract AssemblyTutorialTest is Test {
    AssemblyTutorial tut;

    function setUp() public {
        tut = new AssemblyTutorial();
    }

    /* ============ Step 1: 基础运算 ============ */
    function testAdd() public {
        assertEq(tut.addHigh(2, 3), 5);
        assertEq(tut.addAsm(2, 3), 5);
    }

    /* ============ Step 2: Memory ============ */
    function testHelloBytes() public {
        string memory s = tut.helloBytes();
        assertEq(s, "hello");
    }

    /* ============ Step 3: Calldata ============ */
    function testAddFromCalldata() public {
        // 手工 encode
        bytes memory callData = abi.encodeWithSignature(
            "addFromCalldata(uint256,uint256)",
            10,
            20
        );
        (bool ok, bytes memory out) = address(tut).call(callData);
        assertTrue(ok);
        uint256 sum = abi.decode(out, (uint256));
        assertEq(sum, 30);
    }

    /* ============ Step 4: Storage ============ */
    function testStorage() public {
        address alice = address(0x123);
        tut.setBalAsm(alice, 42);
        assertEq(tut.getBalAsm(alice), 42);
        assertEq(tut.balances(alice), 42); // 高层和底层一致
    }

    /* ============ Step 6: Revert Reason ============ */
    function testRevertReason() public {
        vm.expectRevert(bytes("Not authorized"));
        tut.revertWithReason();
    }
}
```

---

## 4. 运行测试与 gas 报告

```bash
forge test -vvv
forge test --gas-report
```

你会看到：

* `addHigh` vs `addAsm` 的 gas 使用（通常 assembly 少几个 gas）。
* 其他函数的返回与高阶写法一致。
* `revertWithReason` 能正确抛出 `Not authorized`。

---

## 5. 进阶扩展

你可以继续往 `AssemblyTutorial.sol` 里加：

* **Step 5:** `forwardCall` 示例（call 外部合约）。
* **Step 7:** log1 演示。
* **Step 8:** 更多安全陷阱示例。
* **Step 9:** ERC20 transferFrom assembly 版本。

---