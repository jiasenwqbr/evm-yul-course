// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceOpcodeExample {

    // 使用内联汇编查询余额
    function getBalanceAssembly(address addr) public view returns (uint256) {
        uint256 balance_;
        assembly {
            balance_ := balance(addr)
        }
        return balance_;
    }

     // 查询多个地址的余额
    function getMultipleBalances(address[] memory addresses) public view returns (uint256[] memory) {
        uint256[] memory balances = new uint256[](addresses.length);
        
        for (uint256 i = 0; i < addresses.length; i++) {
            assembly {
                // 获取地址
                let addr := mload(add(addresses, add(0x20, mul(i, 0x20))))
                // 查询余额
                let bal := balance(addr)
                // 存储结果
                mstore(add(balances, add(0x20, mul(i, 0x20))), bal)
            }
        }
        return balances;
    }
    
    // 比较不同方式的余额查询
    function compareBalanceMethods(address addr) public view returns (uint256, uint256, bool) {
        // 方法1: 内联汇编
        uint256 balanceAssembly;
        assembly {
            balanceAssembly := balance(addr)
        }
        
        // 方法2: Solidity 的 .balance 属性
        uint256 balanceSolidity = addr.balance;
        
        return (balanceAssembly, balanceSolidity, balanceAssembly == balanceSolidity);
    }
    
    // 检查合约自身余额
    function getContractBalance() public view returns (uint256) {
        uint256 balance_;
        assembly {
            balance_ := selfbalance()
        }
        return balance_;
    }
}


/**
 * 手动构造 EVM 字节码
构造一个查询特定地址余额并返回的合约：

字节码序列:

// 假设要查询的地址通过calldata传入
// calldata: 0x00-0x04: 函数选择器，0x04-0x24: 地址

// 从calldata加载地址
PUSH1 0x04        // calldata 偏移量
CALLDATALOAD      // 加载地址
PUSH1 0x00        // 右移去除高位填充
SHR

// 查询余额
BALANCE           // 0x31

// 将余额存入内存
PUSH1 0x00
MSTORE

// 返回结果
PUSH1 0x20        // 32字节
PUSH1 0x00        // 内存位置
RETURN


 完整字节码序列（简化）：0x60043560001b60005260206000f3
 */