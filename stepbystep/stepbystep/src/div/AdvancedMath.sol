// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
contract AdvancedMath {
    // 计算 (a * b) / c，避免中间结果溢出
    function multiplyThenDivide(
        uint256 a,
        uint256 b,
        uint256 c
    ) public pure returns (uint256) {
        require(c > 0, "Division by zero");
        
        // 先乘后除可能溢出，先除后乘更安全
        return (a / c) * b + ((a % c) * b) / c;
    }
    
    // 使用汇编优化的大数除法
    function optimizedDivision(uint256 a, uint256 b) public pure returns (uint256) {
        assembly {
            // 如果除数为 0，回滚
            if iszero(b) {
                revert(0, 0)
            }
            
            // 如果被除数小于除数，直接返回 0
            if lt(a, b) {
                mstore(0x00, 0)
                return(0x00, 0x20)
            }
            
            // 执行除法
            let result := div(a, b)
            mstore(0x00, result)
            return(0x00, 0x20)
        }
    }
    
    // 计算平方根（使用巴比伦法）
    function sqrt(uint256 x) public pure returns (uint256 y) {
        if (x == 0) return 0;
        
        assembly {
            // 初始猜测
            y := x
            let z := add(div(x, y), y)
            
            // 迭代计算
            for {} lt(y, z) {} {
                z := y
                y := div(add(div(x, y), y), 2)
            }
        }
    }
}
