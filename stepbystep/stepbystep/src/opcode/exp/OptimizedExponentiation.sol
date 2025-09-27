// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract OptimizedExponentiation {
    // 对于小指数，使用循环乘法更省Gas
    function optimizedPow(uint256 base, uint256 exponent) public pure returns (uint256) {
        if (exponent == 0) return 1;
        if (exponent == 1) return base;
        if (base == 0) return 0;
        
        // 小指数：使用循环（更省Gas）
        if (exponent <= 10) {
            uint256 result = 1;
            for (uint256 i = 0; i < exponent; i++) {
                result *= base;
            }
            return result;
        }
        
        // 大指数：使用 EXP 操作码
        assembly {
            let result := exp(base, exponent)
            mstore(0x00, result)
            return(0x00, 32)
        }
    }
    
    // 预计算常见幂次
    function precomputedPowers(uint256 base) public pure returns (uint256[5] memory powers) {
        powers[0] = 1;           // base^0
        powers[1] = base;        // base^1
        powers[2] = base * base; // base^2
        
        // 使用 EXP 计算更高次幂
        assembly {
            // base^3
            let power3 := exp(base, 3)
            mstore(add(powers, 0x60), power3)
            
            // base^4
            let power4 := exp(base, 4)
            mstore(add(powers, 0x80), power4)
        }
    }
}