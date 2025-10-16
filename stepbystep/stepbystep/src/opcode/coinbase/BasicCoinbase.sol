// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract BasicCoinbase {
    /**
     * 使用高级 Solidity 语法获取矿工地址
     */
    function getCoinbaseSolidity() public view returns (address) {
        return block.coinbase;
    }
    
    /**
     * 使用内联汇编获取矿工地址
     */
    function getCoinbaseAssembly() public view returns (address miner) {
        assembly {
            miner := coinbase()
        }
        return miner;
    }
    
    /**
     * 检查当前调用者是否是矿工
     */
    function isCallerMiner() public view returns (bool) {
        return msg.sender == block.coinbase;
    }
    
    /**
     * 获取矿工地址和当前区块信息
     */
    function getMinerInfo() public view returns (
        address miner,
        uint256 blockNumber,
        uint256 timestamp
    ) {
        miner = block.coinbase;
        blockNumber = block.number;
        timestamp = block.timestamp;
        
        return (miner, blockNumber, timestamp);
    }
}



/**
 * 
 1. 什么是 COINBASE？
    COINBASE 操作码用于获取当前区块的矿工（在PoW中）或验证者（在PoS中）的地址。

    操作码值： 0x41

    Gas 消耗： 固定 2 Gas

    栈输入： 无

    栈输出： 1 个参数

    address: 当前区块矿工/验证者的 20 字节地址

2. 工作原理与背景
    矿工/验证者收益：
    区块奖励： 创建新区块时获得的固定奖励

    交易费用： 区块中所有交易的 Gas 费用

    MEV（最大可提取价值）： 通过交易排序等策略获得的额外收益

    在不同共识机制下的表现：
    PoW（工作量证明）： 返回打包当前区块的矿工地址

    PoS（权益证明）： 返回打包当前区块的验证者地址

3. 主要用途
    向矿工/验证者支付小费

    MEV 相关应用

    区块生产者识别

    矿工可提取价值分配

 */