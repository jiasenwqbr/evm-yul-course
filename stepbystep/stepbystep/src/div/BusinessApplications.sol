// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
contract BusinessApplications {
    // 计算价格比率
    function calculatePriceRatio(uint256 priceA, uint256 priceB) public pure returns (uint256) {
        require(priceB > 0, "Price B cannot be zero");
        return priceA / priceB;
    }
    
    // 计算平均值
    function calculateAverage(uint256 total, uint256 count) public pure returns (uint256) {
        require(count > 0, "Count must be positive");
        return total / count;
    }
    
    // 代币兑换计算
    function calculateExchangeRate(
        uint256 inputAmount,
        uint256 outputAmount
    ) public pure returns (uint256) {
        require(inputAmount > 0, "Input amount must be positive");
        return outputAmount / inputAmount;
    }
    
    // 分配奖励
    function distributeRewards(
        uint256 totalReward,
        uint256 totalShares,
        uint256 userShares
    ) public pure returns (uint256) {
        require(totalShares > 0, "No shares to distribute");
        return (totalReward * userShares) / totalShares;
    }
}