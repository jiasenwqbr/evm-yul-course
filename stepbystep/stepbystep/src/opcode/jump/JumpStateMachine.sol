// // SPDX-License-Identifier: UNLICENSED
 pragma solidity ^0.8.13;


// contract JumpStateMachine {
//     function stateMachine(uint256 input) public pure returns (uint256) {
//         assembly {
//             let state := 0 // 初始状态
            
//             jump(process_input)
            
//         state_0:
//             jumpdest
//             // 状态 0 的处理逻辑
//             if eq(input, 1) {
//                 state := 1
//                 jump(process_input)
//             }
//             if eq(input, 2) {
//                 state := 2
//                 jump(process_input)
//             }
//             jump(final_state)
            
//         state_1:
//             jumpdest
//             // 状态 1 的处理逻辑
//             if eq(input, 3) {
//                 state := 3
//                 jump(process_input)
//             }
//             jump(final_state)
            
//         state_2:
//             jumpdest
//             // 状态 2 的处理逻辑
//             if eq(input, 4) {
//                 state := 4
//                 jump(process_input)
//             }
//             jump(final_state)
            
//         state_3:
//             jumpdest
//             // 状态 3 的处理逻辑
//             state := mul(state, 10)
//             jump(final_state)
            
//         state_4:
//             jumpdest
//             // 状态 4 的处理逻辑
//             state := mul(state, 20)
//             jump(final_state)
            
//         process_input:
//             jumpdest
//             // 根据当前状态跳转
//             switch state
//             case 0 { jump(state_0) }
//             case 1 { jump(state_1) }
//             case 2 { jump(state_2) }
//             case 3 { jump(state_3) }
//             case 4 { jump(state_4) }
//             default { jump(final_state) }
            
//         final_state:
//             jumpdest
//             mstore(0x00, state)
//             return(0x00, 0x20)
//         }
//     }
// }