// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ContractDetector {
    // 使用高级Solidity语法检测合约
    function isContractSolidity(address _addr) public view returns (bool) {
        // code.length > 0 表示是合约
        return _addr.code.length > 0;
    }

    // 使用内联汇编检测合约
    function isContractAssembly(address _addr) public view returns (bool) {
        uint32 size;
        assembly {
            // 直接调用 EXTCODESIZE 操作码
            size := extcodesize(_addr)
        }
        return size > 0;
    }

    // 获取合约代码大小
    function getCodeSize(address _addr) public view returns (uint256) {
        return _addr.code.length;
    }

    // 获取合约代码大小（汇编版本）
    function getCodeSizeAssembly(address _addr) public view returns (uint256 size) {
        assembly {
            size := extcodesize(_addr)
        }
    }
}

/**
 
EXTCODESIZE 操作码详解
基本概念
操作码： EXTCODESIZE，十六进制值为 0x3b。

Gas 消耗： 固定为 100（在 EIP-150 硬分叉之后为 700，但实际消耗因账户状态而异）。

栈操作： 从栈中弹出 1 个元素（目标地址），向栈顶压入 1 个元素（代码大小）。

功能： 获取指定以太坊地址的合约代码大小（以字节为单位）。

深入理解
EXTCODESIZE 是什么？
该操作码用于查询指定地址的合约代码长度。如果地址是外部账户（EOA），则返回 0；如果是合约账户，则返回其部署代码的字节长度。

工作原理

从栈顶弹出一个 20 字节的地址

查询该地址的合约代码

将代码大小（字节数）压入栈顶

如果地址不存在或是 EOA，返回 0

Gas 成本说明

冷访问：首次访问某个地址的代码时，消耗 2600 gas

热访问：同一交易中再次访问相同地址时，消耗 100 gas

账户不存在：如果地址没有在状态树中出现过，也按冷访问收费

主要用途

合约检测：判断一个地址是否为合约

代理模式：在代理合约中检查实现合约的代码大小

安全防护：防止合约与 EOA 的意外交互

合约验证：验证合约是否已部署且包含预期代码

 */