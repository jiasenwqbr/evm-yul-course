// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AddExample {
    // 简单的加法函数（Solidity 0.8.0+ 自动检查溢出）
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
    
    // 显式使用 unchecked 块（不检查溢出，模拟旧版本行为）
    function addUnchecked(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }
    
    // 多个加法操作
    function addMultiple(uint256 a, uint256 b, uint256 c) public pure returns (uint256) {
        return a + b + c;
    }
}