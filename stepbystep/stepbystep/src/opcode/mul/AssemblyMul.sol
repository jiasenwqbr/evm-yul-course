// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract AssemblyMul {
    // 使用内联汇编实现乘法
    function mulWtithAssembly(uint256 a,uint256 b) public pure returns (uint256 result) {
        assembly{
            result := mul(a,b)
        }
    }
    // 带溢出检查的汇编乘法
    function safeMul(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := mul(a, b)
            
            // 检查是否溢出：如果 b != 0 且 result / b != a，则发生溢出
            if and(iszero(iszero(b)), iszero(eq(div(result, b), a))) {
                revert(0, 0)
            }
        }
    }
    // 计算 a * b + c
    function multplyAndAdd(uint256 a,uint256 b,uint256 c) public pure returns (uint256) {
        assembly {
            let product := mul(a,b)
            let total := add(product,c)
            // 检查加法是否溢出（如果 product + c < product）
            if lt(total, product) {
                revert(0, 0)
            }
            // 存储结果
            mstore(0x00,total)
            return (0x00,0x20)
        }
    }
    


}