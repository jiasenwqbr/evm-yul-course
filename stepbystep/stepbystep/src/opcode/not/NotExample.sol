// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract NotExample {
    /**
     * @dev 对数值进行按位取反操作
     * @param a 要取反的数值
     * @return result 按位取反的结果
     */
    function bitwiseNot(uint256 a) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := not(a)
        }
        return result;
    }
}

/***
 * 
 * 测试上述函数:
    bitwiseNot(0) = ~0 = 2^256 - 1 = 115792089237316195423570985008687907853269984665640564039457584007913129639935
    bitwiseNot(0b1010) = ~0b1010 = 0b111...1110101（前面全是1）
    bitwiseNot(0xFFFF) = ~0xFFFF = 0xFFFF...FFFF0000（前面全是F，最后4位是0）
 */