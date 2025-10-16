// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;



contract BasicChainId {
    /**
     * 使用高级 Solidity 语法获取链 ID
     */
    function getChainIdSolidity() public view returns (uint256) {
        return block.chainid;
    }
    
    /**
     * 使用内联汇编获取链 ID
     */
    function getChainIdAssembly() public view returns (uint256 chainId) {
        assembly {
            chainId := chainid()
        }
        return chainId;
    }
    
    /**
     * 获取完整的网络信息
     */
    function getNetworkInfo() public view returns (
        uint256 chainId,
        uint256 blockNumber,
        uint256 timestamp,
        address coinbase
    ) {
        chainId = block.chainid;
        blockNumber = block.number;
        timestamp = block.timestamp;
        coinbase = block.coinbase;
        
        return (chainId, blockNumber, timestamp, coinbase);
    }
    
    /**
     * 检查当前网络
     */
    function checkNetwork() public view returns (string memory networkName) {
        uint256 chainId = block.chainid;
        
        if (chainId == 1) {
            return "Ethereum Mainnet";
        } else if (chainId == 5) {
            return "Goerli Testnet";
        } else if (chainId == 11155111) {
            return "Sepolia Testnet";
        } else if (chainId == 137) {
            return "Polygon Mainnet";
        } else if (chainId == 56) {
            return "BNB Chain";
        } else if (chainId == 42161) {
            return "Arbitrum One";
        } else if (chainId == 1337 || chainId == 31337) {
            return "Local Development Network";
        } else {
            return "Unknown Network";
        }
    }
}



/**
 1. 什么是 CHAINID？
CHAINID 操作码用于获取当前以太坊网络的链 ID。每个以太坊兼容的网络都有一个唯一的链 ID。

操作码值： 0x46

Gas 消耗： 固定 2 Gas

栈输入： 无

栈输出： 1 个参数

chainId: 当前网络的链 ID（uint256）

2. 背景与工作原理
链 ID 的重要性：
网络标识： 唯一标识不同的以太坊网络

重放攻击防护： 防止在一个网络上的交易在另一个网络上重放

签名验证： 在交易签名中包含链 ID 确保交易只能在特定网络执行

常见网络的链 ID：
主网： 1

Goerli： 5

Sepolia： 11155111

Polygon： 137

BNB Chain： 56

Arbitrum： 42161

本地开发网络： 通常为 1337 或 31337

3. 主要用途
跨链重放攻击防护

多链合约部署

网络特定逻辑

签名验证增强



 */