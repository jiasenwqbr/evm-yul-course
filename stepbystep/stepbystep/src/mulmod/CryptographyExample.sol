// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 椭圆曲线密码学应用
contract CryptographyExample {
    // secp256k1 曲线的质数模数
    uint256 constant P = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;
    
    // 在有限域 GF(P) 上进行模乘法
    function finiteFieldMultiply(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let result := mulmod(x, y, P)
            mstore(0x00, result)
            return(0x00, 32)
        }
    }
    
    // 模幂运算（使用重复平方法）
    function modExp(
        uint256 base, 
        uint256 exponent, 
        uint256 modulus
    ) public pure returns (uint256 result) {
        result = 1;
        base = base % modulus;
        
        assembly {
            let x := base
            let n := exponent
            
            // 重复平方法
            for {} n {} {
                // 如果当前位为1，乘以当前基值
                if and(n, 1) {
                    result := mulmod(result, x, modulus)
                }
                // 平方基值
                x := mulmod(x, x, modulus)
                // 右移指数
                n := div(n, 2)
            }
        }
    }
}