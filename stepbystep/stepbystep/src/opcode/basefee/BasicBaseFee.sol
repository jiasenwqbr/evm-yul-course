// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract BasicBaseFee {
    /**
     * 使用高级 Solidity 语法获取基础费用
     */
    function getBaseFeeSolidity() public view returns (uint256) {
        return block.basefee;
    }
    
    /**
     * 使用内联汇编获取基础费用
     */
    function getBaseFeeAssembly() public view returns (uint256 baseFee) {
        assembly {
            baseFee := basefee()
        }
        return baseFee;
    }
    
    /**
     * 获取完整的费用信息
     */
    function getFeeInfo() public view returns (
        uint256 baseFee,
        uint256 gasPrice,
        uint256 gasLeft,
        uint256 blockNumber
    ) {
        baseFee = block.basefee;
        gasPrice = tx.gasprice;
        gasLeft = gasleft();
        blockNumber = block.number;
        
        return (baseFee, gasPrice, gasLeft, blockNumber);
    }
    
    /**
     * 计算当前交易的优先费用
     */
    function getPriorityFee() public view returns (uint256) {
        // 优先费用 = 实际支付的 Gas 价格 - 基础费用
        if (tx.gasprice > block.basefee) {
            return tx.gasprice - block.basefee;
        }
        return 0;
    }
    
    /**
     * 检查交易是否包含足够的优先费用
     */
    function hasSufficientPriorityFee(uint256 minPriorityFee) public view returns (bool) {
        return getPriorityFee() >= minPriorityFee;
    }
}