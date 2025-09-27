// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BitmaskExample {
    /**
     * @dev 提取一个字节中的低4位（nibble）
     * @param value 要提取的值
     * @return 低4位的值 (0-15)
     */
    function getLowNibble(uint256 value) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用掩码 0x0F (二进制: 00001111) 提取低4位
            result := and(value, 0x0F)
        }
        return result;
    }
    
    /**
     * @dev 提取数值中的特定几个位（比如位 4-7）
     * @param value 要提取的值
     * @return 位 4-7 的值
     */
    function getBits4To7(uint256 value) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 1. 先右移4位，让目标位移动到最低位
            // 2. 然后用掩码 0x0F 提取低4位
            result := and(shr(4, value), 0x0F)
        }
        return result;
    }
    
    /**
     * @dev 检查特定位是否被设置
     * @param value 要检查的值
     * @param bitPosition 要检查的位位置 (0-255)
     * @return 如果该位被设置（为1）返回 true
     */
    function isBitSet(uint256 value, uint256 bitPosition) public pure returns (bool) {
        bool result;
        assembly {
            // 1. 创建位掩码：将 1 左移到目标位置
            let mask := shl(bitPosition, 1)
            // 2. 使用 AND 检查该位是否被设置
            // 3. 如果结果不为0，说明该位被设置
            result := iszero(iszero(and(value, mask)))
        }
        return result;
    }
}