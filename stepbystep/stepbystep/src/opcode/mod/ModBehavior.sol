// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ModBehavior {
    // 演示取模运算的基本特性
    function moduloProperties() public pure returns (uint256[6] memory results) {
        results[0] = 10 % 3;    // 1
        results[1] = 7 % 5;     // 2
        results[2] = 15 % 5;    // 0 (整除)
        results[3] = 3 % 10;    // 3 (a < b)
        results[4] = 5 % uint256(0);     // 0 (除零)
        results[5] = 0 % 5;     // 0 (零取模)
    }
    
    // 演示循环特性
    function cyclicBehavior(uint256 number) public pure returns (uint256) {
        return number % 7; // 结果总是在 0-6 之间
    }
    
    // 演示取模运算的周期性
    function moduloPeriodicity() public pure returns (uint256[5] memory results) {
        results[0] = 10 % 3;    // 1
        results[1] = 13 % 3;    // 1 (10+3)
        results[2] = 16 % 3;    // 1 (10+6)
        results[3] = 11 % 3;    // 2
        results[4] = 14 % 3;    // 2 (11+3)
    }
}