// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 简单的多项式评估（ZK-SNARKs 中的基础操作）
contract PolynomialVerification {
    // 计算多项式 a₀ + a₁x + a₂x² + ... + aₙxⁿ 在有限域上的值
    function evaluatePolynomial(
        uint256[] memory coefficients, // [a₀, a₁, a₂, ..., aₙ]
        uint256 x,
        uint256 modulus
    ) public pure returns (uint256 result) {
        require(modulus != 0, "Modulus cannot be zero");
        
        assembly {
            let length := mload(coefficients)
            let data := add(coefficients, 0x20)
            
            // 霍纳法则：a₀ + x(a₁ + x(a₂ + ... ))
            result := mload(data) // 从最高次项开始
            
            for { let i := 1 } lt(i, length) { i := add(i, 1) } {
                let coeff := mload(add(data, mul(i, 0x20)))
                // result = result * x + coefficient
                result := mulmod(result, x, modulus)
                result := addmod(result, coeff, modulus)
            }
        }
    }
}