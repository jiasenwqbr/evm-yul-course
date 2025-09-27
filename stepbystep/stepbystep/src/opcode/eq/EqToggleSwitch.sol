// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EqToggleSwitch {
    uint256 private switchState; // 0 表示关，1 表示开
    function toggle() public {
        assembly {
             // 获取当前状态（从存储槽0）
            let currentState := sload(0)
            // 检查当前状态是否等于 0 (关)
            if eq(currentState, 0) {
                // 如果是关，则设置为开 (1)
                sstore(0, 1)
            }
            // 检查当前状态是否等于 1 (开)
            if eq(currentState, 1) {
                // 如果是开，则设置为关 (0)
                sstore(0, 0)
            }

            // 更简洁的写法，使用异或 XOR：
            // let newState := xor(currentState, 1) // 0 XOR 1 = 1, 1 XOR 1 = 0
            // sstore(0, newState)
        }
    }
    function getState() public view returns (uint256) {
        return switchState;
    }
}