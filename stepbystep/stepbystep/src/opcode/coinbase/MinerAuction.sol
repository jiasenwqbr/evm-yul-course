// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract MinerAuction {
    struct Bid {
        address bidder;
        uint256 amount;
        bytes data; // 要执行的调用数据
        bool executed;
    }
    
    mapping(uint256 => Bid) public bids;
    uint256 public bidCounter;
    address public currentMiner;
    
    event BidPlaced(uint256 indexed bidId, address indexed bidder, uint256 amount);
    event BidExecuted(uint256 indexed bidId, address indexed miner, uint256 amount);
    
    constructor() {
        currentMiner = block.coinbase;
    }
    
    /**
     * 放置竞标，支付费用以获得交易优先执行权
     */
    function placeBid(bytes memory callData) public payable returns (uint256 bidId) {
        require(msg.value > 0, "Bid must be greater than 0");
        
        bidId = bidCounter++;
        bids[bidId] = Bid({
            bidder: msg.sender,
            amount: msg.value,
            data: callData,
            executed: false
        });
        
        emit BidPlaced(bidId, msg.sender, msg.value);
        return bidId;
    }
    
    /**
     * 矿工执行竞标交易
     */
    function executeBid(uint256 bidId) public returns (bool success) {
        Bid storage bid = bids[bidId];
        require(!bid.executed, "Bid already executed");
        require(msg.sender == block.coinbase, "Only miner can execute");
        
        // 向矿工支付费用
        (success, ) = msg.sender.call{value: bid.amount}("");
        require(success, "Payment to miner failed");
        
        // 执行竞标者的调用数据
        if (bid.data.length > 0) {
            (success, ) = bid.bidder.call(bid.data);
            // 注意：这里不要求调用成功，因为矿工已经获得费用
        }
        
        bid.executed = true;
        currentMiner = msg.sender;
        
        emit BidExecuted(bidId, msg.sender, bid.amount);
        return true;
    }
    
    /**
     * 获取当前有效竞标数量
     */
    function getActiveBidCount() public view returns (uint256 count) {
        for (uint256 i = 0; i < bidCounter; i++) {
            if (!bids[i].executed) {
                count++;
            }
        }
        return count;
    }
}