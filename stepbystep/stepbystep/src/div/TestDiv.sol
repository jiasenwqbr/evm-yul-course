// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestDiv {
    // 这里如果 b == 0，Solidity 高级语法会自动 revert，避免错误。
    function normalDiv(uint256 a, uint256 b) public pure returns (uint256) {
        return a / b; // Solidity 高级语法
    }
}