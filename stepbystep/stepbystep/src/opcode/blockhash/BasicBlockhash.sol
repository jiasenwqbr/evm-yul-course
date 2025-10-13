// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicBlockhash {
    /**
     * 使用高级 Solidity 语法获取区块哈希
     */
    function getBlockHashSolidity(uint256 blockNumber) public view returns (bytes32) {
        return blockhash(blockNumber);
    }
    
    /**
     * 使用内联汇编获取区块哈希
     */
    function getBlockHashAssembly(uint256 blockNumber) public view returns (bytes32 hash) {
        assembly {
            hash := blockhash(blockNumber)
        }
        return hash;
    }
    
    /**
     * 检查特定区块哈希是否可用
     */
    function isBlockHashAvailable(uint256 blockNumber) public view returns (bool) {
        // 当前区块号
        uint256 currentBlock = block.number;
        
        // 检查是否在有效范围内 [currentBlock-256, currentBlock-1]
        if (blockNumber >= currentBlock - 256 && blockNumber < currentBlock) {
            bytes32 hash = blockhash(blockNumber);
            return hash != 0;
        }
        return false;
    }
    
    /**
     * 获取最近可用区块的哈希
     */
    function getRecentBlockHash() public view returns (bytes32) {
        return blockhash(block.number - 1);
    }
}