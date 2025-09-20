// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract MathOperations{
     // 使用 mul 和 add 实现 (a * b) + (c * d)
    function complexCalculation(
        uint256 a,
        uint256 b, 
        uint256 c,
        uint256 d
    ) public pure returns (uint256) {
        assembly {
            // 计算 a * b
            let ab := mul(a, b)
            // 检查 a*b 溢出
            if and(iszero(iszero(b)), iszero(eq(div(ab, b), a))) {
                revert(0, 0)
            }
            
            // 计算 c * d
            let cd := mul(c, d)
            // 检查 c*d 溢出
            if and(iszero(iszero(d)), iszero(eq(div(cd, d), c))) {
                revert(0, 0)
            }
            
            // 计算 ab + cd
            let result := add(ab, cd)
            // 检查加法溢出
            if lt(result, ab) {
                revert(0, 0)
            }
            
            // 返回结果
            mstore(0x00, result)
            return(0x00, 0x20)
        }
    }
}