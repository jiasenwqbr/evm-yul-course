// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MsizeBasic {
    function getMemorySize() public pure returns (uint256 size) {
        assembly {
            size := msize()
        }
    }
    
    function demonstrateMsizeGrowth() public pure returns (uint256[5] memory sizes) {
        assembly {
            // 初始内存大小
            sizes[0] := msize()
            
            // 分配一些内存
            mstore(0x40, 0x100)
            sizes[1] := msize()
            
            // 分配更多内存
            mstore(0x100, 0x1234567890ABCDEF)
            sizes[2] := msize()
            
            // 使用 mstore 触发内存扩展
            mstore(0x200, 0x1111111111111111)
            sizes[3] := msize()
            
            // 再次检查
            sizes[4] := msize()
        }
    }
    
    function showDefaultMemory() public pure returns (uint256 initialSize) {
        assembly {
            // 新调用开始时，msize 通常为 0x00
            // 但Solidity可能已经分配了一些初始内存
            initialSize := msize()
        }
    }
}

/**
 * 
 1. MSIZE 操作码概述
    操作码： 0x59
    气体消耗： 2 gas
    栈输入： 0 个元素
    栈输出： 1 个元素：size - 当前已分配的内存大小（以字节为单位）
    功能： 获取当前已分配的内存大小。

2. 核心概念与设计目的
    MSIZE 操作码返回当前已分配的内存区域的最高地址，也就是EVM为此合约调用已经分配了多少字节的内存。
    关键特性：
    内存查询：只读操作，不修改任何状态
    分配大小：返回已分配内存的字节数（不是可用内存）
    Gas低廉：只有2 gas，成本很低
    动态增长：内存按32字节的倍数自动扩展
    调试工具：主要用于内存管理和调试

3. 底层工作原理
    内存分配：EVM内存从0x00开始，按需自动扩展
    MSIZE值：返回当前最高分配的内存地址+1
    执行过程：
    MSIZE 读取当前内存大小指针
    将内存大小值压入栈顶
    继续执行下一条指令
    重要细节：MSIZE 返回的是已分配的内存大小，不是已使用的内存大小。
 */