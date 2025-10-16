// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract BasicSelfBalance {
    /**
     * 传统方式获取合约余额
     */
    function getBalanceTraditional() public view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * 使用内联汇编和 SELFBALANCE
     */
    function getBalanceWithSelfBalance() public view returns (uint256 balanc) {
        assembly {
            balanc := selfbalance()
        }
        return balanc;
    }
    
    /**
     * 比较两种方式的 Gas 消耗
     */
    function compareGasCost() public view returns (uint256 traditionalGas, uint256 optimizedGas) {
        // 注意：这只是一个估算，实际 Gas 消耗需要在链上测试
        traditionalGas = 100;  // BALANCE 操作码的 warm 访问成本
        optimizedGas = 2;      // SELFBALANCE 固定成本
        
        return (traditionalGas, optimizedGas);
    }
    
    /**
     * 接收以太币并显示余额变化
     */
    receive() external payable {
        // 当合约接收以太币时自动调用
    }
    
    /**
     * 获取完整的余额信息
     */
    function getBalanceInfo() public view returns (
        uint256 contractBalance,
        uint256 callerBalance,
        uint256 blockNumber
    ) {
        contractBalance = getBalanceWithSelfBalance();
        callerBalance = msg.sender.balance;
        blockNumber = block.number;
        
        return (contractBalance, callerBalance, blockNumber);
    }
}
