// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 代币经济模型：指数型通胀
contract TokenInflation {
    uint256 public constant INITIAL_SUPPLY = 1_000_000e18;
    uint256 public constant INFLATION_RATE = 1.05e18; // 5% 年通胀
    uint256 public constant BLOCKS_PER_YEAR = 210_000; // 假设每年区块数
    
    // 计算第 N 年后的总供应量
    function calculateTotalSupply(uint256 yearsPassed) public pure returns (uint256) {
        uint256 ONE = 1e18;
        
        // total = initial * (1 + rate)^years
        uint256 inflationFactor;
        assembly {
            inflationFactor := exp(INFLATION_RATE, yearsPassed)
        }
        
        return (INITIAL_SUPPLY * inflationFactor) / ONE;
    }
    
    // 计算特定区块时的供应量
    function supplyAtBlock(uint256 blockNumber) public pure returns (uint256) {
        uint256 yearsPassed = blockNumber / BLOCKS_PER_YEAR;
        return calculateTotalSupply(yearsPassed);
    }
}