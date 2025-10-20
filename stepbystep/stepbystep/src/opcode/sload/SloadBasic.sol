// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SloadBasic {
    uint256 public value1 = 0x1234567890ABCDEF;
    uint256 public value2 = 0xFFFFFFFFFFFFFFFF;
    
    function basicSload() public view returns (uint256 result1, uint256 result2) {
        assembly {
            // 从存储槽 0 读取 value1
            result1 := sload(0)
            
            // 从存储槽 1 读取 value2  
            result2 := sload(1)
        }
    }
    
    function demonstrateColdHotAccess() public view returns (uint256 gasUsed) {
        uint256 gasStart = gasleft();
        
        assembly {
            // 第一次读取 - 冷访问 (2100 gas)
            let coldRead := sload(0)
            
            // 第二次读取相同存储槽 - 热访问 (100 gas)
            let hotRead := sload(0)
            
            // 读取不同存储槽 - 冷访问 (2100 gas)
            let anotherCold := sload(1)
            
            // 再次读取存储槽 1 - 热访问 (100 gas)
            let anotherHot := sload(1)
        }
        
        gasUsed = gasStart - gasleft();
    }
}
