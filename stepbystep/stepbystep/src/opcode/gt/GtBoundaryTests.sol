// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BoundaryTests {
    // 使用 GT 实现最大值查找
    function findMax(uint256 a, uint256 b, uint256 c) public pure returns (uint256 max) {
        assembly {
            // 比较 a 和 b
            if gt(a, b) {
                // a > b，比较 a 和 c
                if gt(a, c) {
                    max := a
                }
                max := c
            }
            {
                // b >= a，比较 b 和 c
                if gt(b, c) {
                    max := b
                }
                    max := c
            }
        }
    }
}