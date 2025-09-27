// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ModExample {
    // 基础取模运算
    function mod(uint256 a, uint256 b) public pure returns (uint256) {
        return a % b;
    }
    
    // 带安全检查的取模
    function safeMod(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0, "Modulo by zero");
        return a % b;
    }
    
    // 检查是否为偶数
    function isEven(uint256 number) public pure returns (bool) {
        return number % 2 == 0;
    }
    
    // 检查是否为奇数
    function isOdd(uint256 number) public pure returns (bool) {
        return number % 2 == 1;
    }
}