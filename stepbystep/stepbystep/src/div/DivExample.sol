// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
contract DivExample {
     // 基础除法
    function div(uint256 a, uint256 b) public pure returns (uint256) {
        return a / b;
    }
    
    // 带除零检查的除法
    function safeDiv(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0, "Division by zero");
        return a / b;
    }
    
    // 计算百分比
    function percentage(uint256 numerator, uint256 denominator) public pure returns (uint256) {
        require(denominator > 0, "Denominator must be positive");
        return (numerator * 100) / denominator;
    }
}