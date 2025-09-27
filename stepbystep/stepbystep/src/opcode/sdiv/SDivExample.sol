// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SDivExample {
    // 基础有符号除法
    function sdiv(int256 a, int256 b) public pure returns (int256) {
        return a / b;
    }
    
    // 带除零检查的有符号除法
    function safeSDiv(int256 a, int256 b) public pure returns (int256) {
        require(b != 0, "Signed division by zero");
        return a / b;
    }
    
    // 演示向零取整特性
    function truncationExamples() public pure returns (int256[4] memory results) {
        results[0] = 7 / int256(3);    // 2
        results[1] = -7 /int256(3);   // -2
        results[2] = 7 / int256(-3);   // -2
        results[3] = -7 / int256(-3);  // 2
    }
}