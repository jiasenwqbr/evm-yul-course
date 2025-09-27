// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract XorBitToggle {
     /**
     * @dev 切换特定位的状态（0变1，1变0）
     * @param value 原始值
     * @param bitPosition 要切换的位位置 (0-255)
     * @return 切换位后的值
     */
    function toggleBit(uint256 value, uint256 bitPosition) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 创建位掩码：只有目标位为1
            let mask := shl(bitPosition, 1)
            // 使用 XOR 切换该位：相同变0，不同变1
            result := xor(value, mask)
        }
        return result;
    }
    
    /**
     * @dev 切换多个位的状态
     * @param value 原始值
     * @param bitMask 位掩码，要切换的位设为1
     * @return 切换位后的值
     */
    function toggleBits(uint256 value, uint256 bitMask) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := xor(value, bitMask)
        }
        return result;
    }
    
    /**
     * @dev 实现简单的开关切换（布尔值取反）
     */
    function toggleSwitch(uint256 switchState) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 如果 switchState 是 0 或 1，可以使用 XOR 1 来切换
            // 0 ^ 1 = 1, 1 ^ 1 = 0
            result := xor(switchState, 1)
        }
        return result;
    }
}