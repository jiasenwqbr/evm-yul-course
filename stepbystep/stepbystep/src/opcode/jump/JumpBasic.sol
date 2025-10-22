// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.26;

// contract JumpBasic {
//     function basicJump() public pure returns (uint256 result) {

//         assembly {
//             // 定义标签
//             let label1 := 1
            
//             // 跳转到 label1
//             jump(label1)
            
//             // 这行代码会被跳过
//             mstore(0x00, 0x1111111111111111)
            
//             // 跳转目标
//             jumpdest  // 这个 jumpdest 对应 label1
//         }
        
//         assembly {
//             // 设置返回值（在另一个汇编块中）
//             mstore(0x00, 0x1234567890ABCDEF)
//             return(0x00, 0x20)
//         }
//     }

// }
