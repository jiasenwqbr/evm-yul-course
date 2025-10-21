// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract JumpBasic {
    function basicJump() public pure returns (uint256 result) {
        assembly {
            // 跳转到 label1
            jump(label1)
            
            // 这行代码会被跳过
            mstore(0x00, 0x1111111111111111)
            
        label1:
            // 跳转目标必须是 JUMPDEST
            jumpdest
            
            // 设置返回值
            mstore(0x00, 0x1234567890ABCDEF)
            return(0x00, 0x20)
        }
    }
    
    function multipleJumps() public pure returns (uint256) {
        assembly {
            let x := 0
            
            // 第一次跳转
            jump(loop_start)
            
        skip_region:
            jumpdest
            x := add(x, 100)  // 这会被跳过
            jump(loop_end)
            
        loop_start:
            jumpdest
            x := add(x, 1)    // x = 1
            
            // 跳转到另一个区域
            jump(calculation)
            
        after_calculation:
            jumpdest
            x := mul(x, 2)    // x = 2 * 7 = 14
            jump(loop_end)
            
        calculation:
            jumpdest
            x := add(x, 6)    // x = 1 + 6 = 7
            jump(after_calculation)
            
        loop_end:
            jumpdest
            mstore(0x00, x)   // x = 14
            return(0x00, 0x20)
        }
    }
}