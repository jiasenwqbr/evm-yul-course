// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ByteExample {
    /**
     * @dev 从32字节值中提取指定位置的字节
     * @param value 32字节的值
     * @param position 字节位置 (0-31)
     * @return 提取的字节（高位补零到32字节）
     */
    function extrtactByte(uint256 value,uint256 position) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := byte(position,value)
        }
        return result;
    }

    /**
     * @dev 提取多个字节并组合
     */
    function extractByte(uint256 value, uint256 startPos, uint256 length) public pure returns (uint256) {
        require(length > 0 && length <= 32, "Invalid length");
        require(startPos + length <= 32, "Position out of range");
        
        uint256 result;
        assembly {
            // 逐个提取字节并组合
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let pos := add(startPos, i)
                let b := byte(pos, value)
                // 将字节左移到正确位置
                let shifted := shl(mul(sub(31, pos), 8), b)
                result := or(result, shifted)
            }
        }
        return result;
    }



}

/***
 * 
    // 假设 value = 0x1234567890ABCDEF...
    // extractByte(value, 0) 返回 0x12 (最高位字节)
    // extractByte(value, 1) 返回 0x34
    // extractByte(value, 31) 返回最低位字节
 */