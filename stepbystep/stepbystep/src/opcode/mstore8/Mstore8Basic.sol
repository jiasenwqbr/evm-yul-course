// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Mstore8Basic {
    function basicMstore8() public pure returns (bytes32 result) {
        assembly {
            // 在内存位置 0x00 存储单个字节 0xAB
            mstore8(0x00, 0xAB)
            
            // 验证：使用 mload 读取32字节
            result := mload(0x00)
            // result = 0xAB00000000000000000000000000000000000000000000000000000000000000
            // 只有第一个字节被设置，其余31字节为0
        }
    }
    
    function demonstrateByteExtraction() public pure {
        assembly {
            // MSTORE8 只使用最低有效字节
            mstore8(0x00, 0x12345678) // 实际存储 0x78
            mstore8(0x01, 0xABCD)     // 实际存储 0xCD
            mstore8(0x02, 0xFF)       // 实际存储 0xFF
            mstore8(0x03, 0x42)       // 实际存储 0x42
            
            // 读取整个32字节查看结果
            let stored := mload(0x00)
            // stored = 0x42FFCD7800000000000000000000000000000000000000000000000000000000
            // 注意字节顺序：小端序在内存中的表示
        }
    }
}

/** 示例 ：基本字节存储
 1. MSTORE8 操作码概述
    操作码： 0x53
    气体消耗： 3 gas（如果写入的是新内存区域，根据EIP-2929会有额外费用），加上可能的内存扩展费用。
    栈输入： 2 个元素：
    offset： 要写入的内存起始位置（以字节为单位）
    value： 要存储的 1 字节值（仅使用最低有效字节）
    栈输出： 0 个元素
    功能： 将一个值的最低有效字节写入EVM内存的指定偏移量处。
2. 核心概念与设计目的
    MSTORE8 是 MSTORE 的字节级版本，专门用于按字节操作内存数据。
    关键特性：
        只写入1字节：与 MSTORE 总是写入32字节不同，MSTORE8 只写入1个字节。
        仅使用最低有效字节：无论 value 参数是多少（32字节），MSTORE8 只使用其最低有效字节（最低的8位）。
        内存扩展：如果 MSTORE8 的 offset + 1 超出了当前已分配的内存大小，EVM会扩展内存（消耗额外的Gas）。
        字节级操作：特别适合处理字符串、字节数组、编码数据等需要逐字节操作的情况。
3. 与 MSTORE 的关键区别
    特性	    MSTORE	    MSTORE8
    写入大小	32字节	        1字节
    使用数据	完整的256位值	 仅最低8位
    典型用途	存储整数、地址、哈希值	存储字符、字节数据、打包数据
    内存影响	影响32字节范围	只影响1字节
4. 底层工作原理
    执行过程：
        MSTORE8 从栈顶弹出 offset 和 value。
        检查 offset + 1 是否超过了当前内存大小。
        如果超过，则扩展内存到 offset + 1，并将扩展部分初始化为0。
        提取 value 的最低有效字节：byteValue = value & 0xFF
        将 byteValue 存储到内存的 offset 位置。
        操作完成，栈减少2个元素。
 */