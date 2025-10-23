// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Dup1Example {
    function dup1Basic() public pure returns (uint256, uint256) {
        uint256 a;
        uint256 b;
        assembly {
            // 模拟 dup1：保存一个值两次
            let value := 0x42
            a := value
            b := value
        }
        return (a, b);  // (0x42, 0x42)
    }

    function dup1ForMultipleUse() public pure returns (uint256) {
        uint256 result;
        assembly {
            let value := 10
            // 模拟 dup1：直接用 value 参与多次计算
            result := mul(value, value) // 10 * 10 = 100
        }
        return result;
    }

    function dup1InArithmetic() public pure returns (uint256) {
        uint256 result;
        assembly {
            let x := 5
            // 模拟 dup1, dup1, mul, add
            let square := mul(x, x)
            result := add(square, x) // x² + x = 30
        }
        return result;
    }
}

/**
 * 
 *
 DUP 系列操作码是 EVM 栈管理的核心：

DUP1-DUP5：常用，用于复制浅层栈元素

DUP6-DUP10：用于中等深度栈操作

DUP11-DUP16：用于深层栈操作，接近栈限制

合理使用 DUP 操作码可以：

避免重复计算

简化复杂的数据流

提高代码可读性

优化 Gas 消耗
 */