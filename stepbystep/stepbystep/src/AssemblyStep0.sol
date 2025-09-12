// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssemblyStep0 {
    // 高层写法
    function addHigh(uint256 a,uint256 b) external pure returns(uint256) {
        return a + b;
    }

    // 内联汇编写法
    function addAsm(uint256 a,uint256 b) external pure returns(uint256 res) {
        assembly {
            res := add(a,b) // 使用EVM add指令
        }
    }
}