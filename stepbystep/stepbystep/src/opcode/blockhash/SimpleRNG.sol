// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract SimpleRNG {
    mapping(address => uint256) public userSeeds;
    
    /**
     * 使用区块哈希和用户地址生成随机数
     * 注意：这种方法在矿工可操纵的场景下不安全
     */
    function generateRandomNumber() public returns (uint256) {
        // 记录用户调用时的区块号作为种子
        userSeeds[msg.sender] = block.number;
        
        // 在后续区块中获取哈希来生成随机数
        // 实际应用中应该使用 commit-reveal 模式
        uint256 random = uint256(keccak256(abi.encodePacked(
            blockhash(block.number - 1),
            msg.sender,
            block.timestamp
        )));
        
        return random % 100; // 返回 0-99 的随机数
    }
    
    /**
     * 更安全的随机数生成 - 使用之前的区块哈希
     */
    function saferRandom(uint256 seed) public view returns (uint256) {
        // 使用前一个区块的哈希，减少矿工操纵的可能性
        bytes32 previousBlockHash = blockhash(block.number - 1);
        
        // 结合用户提供的种子
        uint256 random = uint256(keccak256(abi.encodePacked(
            previousBlockHash,
            msg.sender,
            seed,
            block.difficulty
        )));
        
        return random;
    }
}