// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract JumpiBasic {
    function basicConditional(uint256 x) public pure returns (uint256) {
        assembly {
            // 如果 x > 100，跳转到 large_number
            gt(x, 100)
            jumpi(large_number, gt(x, 100))
            
            // 小数字的处理（顺序执行）
            mstore(0x00, 1) // 返回 1 表示小数字
            return(0x00, 0x20)
            
        large_number:
            jumpdest
            mstore(0x00, 2) // 返回 2 表示大数字
            return(0x00, 0x20)
        }
    }
    
    function multipleConditions(uint256 a, uint256 b) public pure returns (uint256) {
        assembly {
            // 条件 1: a == b
            eq(a, b)
            jumpi(equal, eq(a, b))
            
            // 条件 2: a > b
            gt(a, b)
            jumpi(a_greater, gt(a, b))
            
            // 默认情况: a < b
            mstore(0x00, 3) // 3 表示 a < b
            return(0x00, 0x20)
            
        equal:
            jumpdest
            mstore(0x00, 1) // 1 表示相等
            return(0x00, 0x20)
            
        a_greater:
            jumpdest
            mstore(0x00, 2) // 2 表示 a > b
            return(0x00, 0x20)
        }
    }
}