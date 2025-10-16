// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicBlockNumber {
    /**
     * 使用高级 Solidity 语法获取区块号
     */
    function getBlockNumberSolidity() public view returns (uint256) {
        return block.number;
    }
    
    /**
     * 使用内联汇编获取区块号
     */
    function getBlockNumberAssembly() public view returns (uint256 blockNum) {
        assembly {
            blockNum := number()
        }
        return blockNum;
    }
    
    /**
     * 获取当前区块信息
     */
    function getBlockInfo() public view returns (
        uint256 blockNumber,
        uint256 timestamp,
        address coinbase
    ) {
        blockNumber = block.number;
        timestamp = block.timestamp;
        coinbase = block.coinbase;
        
        return (blockNumber, timestamp, coinbase);
    }
    
    /**
     * 计算平均出块时间（与之前区块比较）
     */
    function calculateBlockTime() public view returns (uint256) {
        // 注意：这需要知道前一个区块的时间戳
        // 在实际中，需要存储历史数据来计算
        return block.timestamp;
    }
}


/**
 
 1. 什么是 NUMBER？
NUMBER 操作码用于获取当前区块的区块号（区块高度）。

操作码值： 0x43

Gas 消耗： 固定 2 Gas

栈输入： 无

栈输出： 1 个参数

blockNumber: 当前区块的编号（从创世区块 0 开始）

2. 工作原理与特性
关键特性：
单调递增： 每个新区块的编号都比前一个区块大 1

不可篡改： 区块号是区块链共识的一部分，无法被修改

精确可靠： 相比时间戳，区块号更不容易被操纵

全局一致： 所有节点在同一区块高度看到的区块号相同

与时间戳的比较：
区块号： 精确、不可操纵、线性增长

时间戳： 近似、可轻微操纵、非线性增长

3. 主要用途
基于区块的时间计算

合约状态快照

伪随机数生成

分阶段合约逻辑

数据版本控制
 */