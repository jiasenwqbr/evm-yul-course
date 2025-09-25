// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract LtBasic {
     // 使用 LT 操作码
    function lessThan(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := lt(a, b)
        }
    }
    
    // 比较 Solidity 内置操作符
    function solidityLessThan(uint256 a, uint256 b) public pure returns (bool) {
        return a < b;
    }
    
    // 演示各种比较情况
    function demonstrateComparisons() public pure returns (bool[6] memory results) {
        results[0] = lessThan(5, 10) == 1;      // 5 < 10 → true
        results[1] = lessThan(10, 5) == 1;      // 10 < 5 → false
        results[2] = lessThan(5, 5) == 1;       // 5 < 5 → false
        results[3] = lessThan(0, 1) == 1;       // 0 < 1 → true
        results[4] = lessThan(2**255, 2**256 - 1) == 1; // 大数比较 → true
        results[5] = lessThan(2**256 - 1, 2**255) == 1; // 大数比较 → false
    }
}