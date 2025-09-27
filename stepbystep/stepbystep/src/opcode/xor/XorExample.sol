// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract XorExample {
    /**
     * @dev 对两个数进行按位异或操作
     * @param a 第一个数
     * @param b 第二个数
     * @return result 按位异或的结果
     */
    function bitwiseXor(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := xor(a, b)
        }
        return result;
    }
}

/**
 * 
 * 测试上述函数:

bitwiseXor(0b1100, 0b1010) = 0b1100 ^ 0b1010 = 0b0110 (6)

bitwiseXor(0xFF, 0xAA) = 0xFF ^ 0xAA = 0x55 (85)

bitwiseXor(15, 7) = 15 ^ 7 = 8


 */