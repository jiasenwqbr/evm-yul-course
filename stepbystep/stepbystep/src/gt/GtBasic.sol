// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GtBasic {
    // 使用 GT 操作码
    function greaterThan(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := gt(a, b)
        }
    }

    // 比较 Solidity 内置操作符
    function solidityGreaterThan(uint256 a, uint256 b) public pure returns (bool) {
        return a > b;
    }
    
    // 演示各种比较情况
    function demonstrateComparisons() public pure returns (bool[6] memory results) {
        results[0] = greaterThan(10, 5) == 1;      // 10 > 5 → true
        results[1] = greaterThan(5, 10) == 1;      // 5 > 10 → false
        results[2] = greaterThan(5, 5) == 1;       // 5 > 5 → false
        results[3] = greaterThan(1, 0) == 1;       // 1 > 0 → true
        results[4] = greaterThan(2**255, 2**250) == 1; // 大数比较 → true
        results[5] = greaterThan(2**250, 2**255) == 1; // 大数比较 → false
    }
}