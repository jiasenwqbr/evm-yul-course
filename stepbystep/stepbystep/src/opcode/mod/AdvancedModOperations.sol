// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
contract AdvancedModOperations {
    // 模幂运算 (base^exponent % modulus)
    function modPow(
        uint256 base,
        uint256 exponent,
        uint256 modulus
    ) public pure returns (uint256 result) {
        require(modulus > 0, "Modulus must be positive");
        
        if (modulus == 1) return 0;
        
        assembly {
            result := 1
            base := mod(base, modulus)
            
            for { } gt(exponent, 0) { } {
                // 如果 exponent 是奇数
                if and(exponent, 1) {
                    result := mod(mul(result, base), modulus)
                }
                // exponent = exponent / 2
                exponent := div(exponent, 2)
                base := mod(mul(base, base), modulus)
            }
        }
    }
    
    // 模加法：(a + b) % modulus
    function modAdd(
        uint256 a,
        uint256 b,
        uint256 modulus
    ) public pure returns (uint256) {
        require(modulus > 0, "Modulus must be positive");
        assembly {
            let sum := add(a, b)
            // 检查加法是否溢出
            if lt(sum, a) {
                // 如果溢出，需要特殊处理
                sum := mod(add(mod(a, modulus), mod(b, modulus)), modulus)
            }
            sum := mod(sum, modulus)
            mstore(0x00, sum)
            return(0x00, 0x20)
        }
    }
    
    // 模乘法：(a * b) % modulus
    function modMul(
        uint256 a,
        uint256 b,
        uint256 modulus
    ) public pure returns (uint256) {
        require(modulus > 0, "Modulus must be positive");
        
        assembly {
            a := mod(a, modulus)
            b := mod(b, modulus)
            let product := mul(a, b)
            product := mod(product, modulus)
            mstore(0x00, product)
            return(0x00, 0x20)
        }
    }
}