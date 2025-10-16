// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;



contract MinerTip {
    event TipSent(address indexed from, address indexed to, uint256 amount);
    event TipReceived(address indexed miner, uint256 amount);
    
    /**
     * 向当前区块的矿工支付小费
     */
    function tipMiner() public payable {
        require(msg.value > 0, "Tip must be greater than 0");
        address miner = block.coinbase;
        
        // 向矿工转账
        (bool success, ) = miner.call{value: msg.value}("");
        require(success, "Transfer failed");
        
        emit TipSent(msg.sender, miner, msg.value);
    }
    
    /**
     * 带消息的矿工小费
     */
    function tipMinerWithMessage(string memory message) public payable {
        require(msg.value > 0, "Tip must be greater than 0");
        address miner = block.coinbase;
        
        // 向矿工转账
        (bool success, ) = miner.call{value: msg.value}("");
        require(success, "Transfer failed");
        
        emit TipSent(msg.sender, miner, msg.value);
        // 在实际应用中，可以记录消息
    }
    
    /**
     * 批量向多个区块的矿工支付小费（需要预先知道地址）
     */
    function tipMultipleMiners(address[] memory miners, uint256 amountEach) public payable {
        require(miners.length > 0, "No miners specified");
        require(msg.value == amountEach * miners.length, "Incorrect ETH amount");
        
        for (uint256 i = 0; i < miners.length; i++) {
            (bool success, ) = miners[i].call{value: amountEach}("");
            require(success, "Transfer to miner failed");
            
            emit TipSent(msg.sender, miners[i], amountEach);
        }
    }
    
    /**
     * 接收以太币并自动转发给矿工
     */
    receive() external payable {
        address miner = block.coinbase;
        if (msg.value > 0) {
            (bool success, ) = miner.call{value: msg.value}("");
            if (success) {
                emit TipReceived(miner, msg.value);
            }
        }
    }
    
    /**
     * 查询合约余额
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}