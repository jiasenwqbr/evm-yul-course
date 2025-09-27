// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MulModExample {
    // 使用 MULMOD 操作码（安全）
    function safeMulMod(uint256 a, uint256 b, uint256 modulus) public pure returns (uint256) {
        assembly {
            let result := mulmod(a, b, modulus)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

    // 常规乘法后取模（可能溢出）
    function unsafeMulMod(uint256 a, uint256 b, uint256 modulus) public pure returns (uint256) {
        unchecked {
            return (a * b) % modulus;
        }
    }

    // 演示溢出场景
    function demonstrateOverflow() public pure returns (uint256 safeResult, uint256 unsafeResult) {
        uint256 a = 2**128;       // 非常大的数
        uint256 b = 2**128;       // 非常大的数
        uint256 modulus = 1000;
        
        // a * b = 2^256，这会溢出 uint256 的范围
        safeResult = safeMulMod(a, b, modulus);    // 正确结果: 0
        unsafeResult = unsafeMulMod(a, b, modulus); // 错误结果: 0（但由于溢出逻辑错误）
    }

}