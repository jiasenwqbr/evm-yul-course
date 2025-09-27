// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SubExample {
    // 安全的减法（自动下溢检查）
    function sub(uint256 a, uint256 b) public pure returns (uint256) {
        return a - b;
    }
    
    // 不使用下溢检查
    function subUnchecked(uint256 a, uint256 b) public pure returns (uint256) {
        unchecked {
            return a - b;
        }
    }
    
    // 计算绝对值差
    function absoluteDifference(uint256 a, uint256 b) public pure returns (uint256) {
        return a > b ? a - b : b - a;
    }
}