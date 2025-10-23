// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MCOPYComparison {
    bytes data;
    
    constructor() {
        data = hex"1234567890ABCDEF1234567890ABCDEF";
    }
    
    // 传统方式：使用 MLOAD + MSTORE 循环
    function copyMemoryTraditional(bytes memory input) public pure returns (bytes memory) {
        bytes memory result = new bytes(input.length);
        
        assembly {
            let length := mload(input)
            let src := add(input, 0x20)  // 跳过长度前缀
            let dest := add(result, 0x20)
            
            // 传统复制方式 - 32 字节为步长循环
            for { let i := 0 } lt(i, length) { i := add(i, 0x20) } {
                let srcOffset := add(src, i)
                let destOffset := add(dest, i)
                let chunk := mload(srcOffset)
                mstore(destOffset, chunk)
            }
            
            // 处理剩余不足 32 字节的部分
            let remaining := mod(length, 0x20)
            if gt(remaining, 0) {
                let srcEnd := add(src, sub(length, remaining))
                let destEnd := add(dest, sub(length, remaining))
                let lastChunk := mload(srcEnd)
                mstore(destEnd, lastChunk)
            }
        }
        
        return result;
    }
    
    // 使用 MCOPY 的现代方式
    function copyMemoryWithMCOPY(bytes memory input) public pure returns (bytes memory) {
        bytes memory result = new bytes(input.length);
        
        assembly {
            let length := mload(input)
            let src := add(input, 0x20)  // 跳过长度前缀
            let dest := add(result, 0x20)
            
            // 使用 MCOPY - 一行代码搞定！
            mcopy(dest, src, length)
        }
        
        return result;
    }
}

/**
 * 
 1. MCOPY 是什么？
    MCOPY 是 Ethereum Cancun 升级（Dencun 硬分叉，于 2024 年 3 月 13 日激活）中引入的一个新的 EVM 操作码。它是 EIP-5656 提案的一部分，旨在提供更高效的内存复制操作。
    操作码编号： 0x5e
    Gas 成本： 3 + 3 * (length / 32)（比使用 MLOAD/MSTORE 循环更高效）
    功能： 从内存的一个区域复制数据到另一个区域。
    栈输入： 3 个元素：
    dest - 目标内存地址（复制到的位置）
    src - 源内存地址（复制源的位置）
    length - 要复制的字节长度
    栈输出： 无

2. MCOPY 的核心优势
    在 MCOPY 引入之前，要实现内存复制需要使用 MLOAD 和 MSTORE 的组合，这既低效又昂贵。
 */