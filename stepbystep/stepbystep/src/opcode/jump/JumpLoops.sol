// // SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// contract JumpLoops {
//     function simpleLoop(uint256 n) public pure returns (uint256 sum) {
//         assembly {
//             let i := 0
//             sum := 0
            
//             // 循环开始
//             jump(loop_check)
            
//         loop_body:
//             jumpdest
//             sum := add(sum, i)
//             i := add(i, 1)
            
//         loop_check:
//             jumpdest
//             // 检查 i < n
//             if lt(i, n) {
//                 jump(loop_body)
//             }
            
//             // 循环结束
//             mstore(0x00, sum)
//             return(0x00, 0x20)
//         }
//     }
    
//     function factorial(uint256 n) public pure returns (uint256 result) {
//         assembly {
//             result := 1
//             let i := 1
            
//             jump(loop_check)
            
//         loop_body:
//             jumpdest
//             result := mul(result, i)
//             i := add(i, 1)
            
//         loop_check:
//             jumpdest
//             if lt(i, add(n, 1)) {
//                 jump(loop_body)
//             }
            
//             mstore(0x00, result)
//             return(0x00, 0x20)
//         }
//     }
// }