// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract BasicPrevRandao {
    /**
     * 使用高级 Solidity 语法获取 PREVRANDAO
     */
    function getPrevRandaoSolidity() public view returns (uint256) {
        return block.prevrandao;
    }
    
    /**
     * 使用内联汇编获取 PREVRANDAO
     */
    function getPrevRandaoAssembly() public view returns (uint256 randomValue) {
        assembly {
            randomValue := prevrandao()
        }
        return randomValue;
    }
    
    /**
     * 比较不同版本的获取方式
     */
    function getRandomSources() public view returns (
        uint256 prevRandao,
        uint256 difficulty, // 在 PoS 中与 prevrandao 相同
        uint256 blockNumber,
        uint256 timestamp
    ) {
        prevRandao = block.prevrandao;
        difficulty = block.difficulty; // 向后兼容，返回与 prevrandao 相同的值
        blockNumber = block.number;
        timestamp = block.timestamp;
        
        return (prevRandao, difficulty, blockNumber, timestamp);
    }
    
    /**
     * 检查运行环境（PoS vs PoW）
     */
    function getChainInfo() public view returns (bool isPos, uint256 chainId) {
        // 在 PoS 中，difficulty 和 prevrandao 返回相同的值
        // 在 PoW 中，difficulty 返回实际难度值
        isPos = (block.difficulty == block.prevrandao);
        chainId = block.chainid;
        
        return (isPos, chainId);
    }
}