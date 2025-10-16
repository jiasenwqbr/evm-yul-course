// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicGasLimit {
    /**
     * 使用高级 Solidity 语法获取 Gas Limit
     */
    function getGasLimitSolidity() public view returns (uint256) {
        return block.gaslimit;
    }
    
    /**
     * 使用内联汇编获取 Gas Limit
     */
    function getGasLimitAssembly() public view returns (uint256 gasLimit) {
        assembly {
            gasLimit := gaslimit()
        }
        return gasLimit;
    }
    
    /**
     * 获取完整的区块 Gas 信息
     */
    function getGasInfo() public view returns (
        uint256 blockGasLimit,
        uint256 currentGasLeft,
        uint256 gasPrice,
        uint256 blockNumber
    ) {
        blockGasLimit = block.gaslimit;
        currentGasLeft = gasleft();
        gasPrice = tx.gasprice;
        blockNumber = block.number;
        
        return (blockGasLimit, currentGasLeft, gasPrice, blockNumber);
    }
    
    /**
     * 计算当前交易的 Gas 使用比例
     */
    function getGasUsageRatio() public view returns (uint256 used, uint256 remaining, uint256 usagePercentage) {
        uint256 initialGas = block.gaslimit;
        uint256 currentGas = gasleft();
        
        // 估算已使用的 Gas（注意：这不包括当前函数的调用成本）
        used = initialGas - currentGas;
        remaining = currentGas;
        usagePercentage = (used * 100) / initialGas;
        
        return (used, remaining, usagePercentage);
    }
}