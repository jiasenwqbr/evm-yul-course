// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MulExample {
    // 安全的乘法（自动溢出检查）
    function mul(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }
    
    // 不使用溢出检查（更省Gas，但需开发者确保安全）
    function mulUnchecked(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
            return a * b;
        }
    }
    
    // 计算平方
    function square(uint256 x) public pure returns (uint256) {
        return x * x;
    }
    
    // 计算立方
    function cube(uint256 x) public pure returns (uint256) {
        return x * x * x;
    }
}