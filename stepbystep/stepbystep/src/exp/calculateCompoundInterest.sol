// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 金融应用：复利计算
contract CompoundInterest {
    // 计算复利：amount * (1 + rate)^periods
    function calculateCompoundInterest(
        uint256 principal,
        uint256 rate,      // 以 1e18 为精度的利率（1e18 = 100%）
        uint256 periods
    ) public pure returns (uint256) {
        uint256 ONE = 1e18;
        
        // (1 + rate)^periods
        uint256 growthFactor;
        assembly {
            let base := add(ONE, rate)
            growthFactor := exp(base, periods)
        }
        
        // principal * growthFactor / 1e18（保持精度）
        return (principal * growthFactor) / ONE;
    }
    
    // 更精确的版本，防止中间溢出
    function calculateCompoundInterestPrecise(
        uint256 principal,
        uint256 rate,
        uint256 periods
    ) public pure returns (uint256) {
        uint256 ONE = 1e18;
        
        if (periods == 0) return principal;
        
        uint256 result = principal;
        
        // 使用循环避免大数指数运算（更省Gas）
        for (uint256 i = 0; i < periods; i++) {
            result = (result * (ONE + rate)) / ONE;
        }
        
        return result;
    }
}