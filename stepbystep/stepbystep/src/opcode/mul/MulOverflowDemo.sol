// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MulOverflowDemo {
    // 此函数会因溢出而回滚
    function willRevert() public pure returns (uint256) {
        uint256 largeNumber = 2**128; // 一个很大的数
        return largeNumber * largeNumber; // 2^256，刚好溢出
    }
    
    // 此函数使用 unchecked，会返回 0
    function willWrap() public pure returns (uint256) {
        unchecked {
            uint256 largeNumber = 2**128;
            return largeNumber * largeNumber; // 返回 0 (2^256 % 2^256 = 0)
        }
    }
    
    // 演示非零的溢出结果
    function nonZeroOverflow() public pure returns (uint256) {
        unchecked {
            // 2^255 * 3 = 3 * 2^255
            // 3 * 2^255 % 2^256 = 2^255 (因为 3*2^255 - 2^256 = 2^255)
            uint256 a = 2**255;
            uint256 b = 3;
            return a * b; // 返回 2^255
        }
    }
}