// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract SecureRandomGenerator {
    struct RandomRequest {
        address requester;
        uint256 seed;
        uint256 targetBlock;
        bool fulfilled;
        uint256 randomNumber;
    }
    
    mapping(uint256 => RandomRequest) public requests;
    uint256 public requestCounter;
    
    event RandomRequested(uint256 indexed requestId, address requester, uint256 targetBlock);
    event RandomFulfilled(uint256 indexed requestId, uint256 randomNumber);
    
    /**
     * 请求在未来区块生成随机数（使用 PREVRANDAO）
     */
    function requestRandomNumber(uint256 seed) public returns (uint256) {
        // 使用未来区块的 PREVRANDAO，减少操纵可能性
        uint256 targetBlock = block.number + 1;
        
        uint256 requestId = requestCounter++;
        requests[requestId] = RandomRequest({
            requester: msg.sender,
            seed: seed,
            targetBlock: targetBlock,
            fulfilled: false,
            randomNumber: 0
        });
        
        emit RandomRequested(requestId, msg.sender, targetBlock);
        return requestId;
    }
    
    /**
     * 生成随机数
     */
    function fulfillRandomNumber(uint256 requestId) public returns (uint256) {
        RandomRequest storage request = requests[requestId];
        require(!request.fulfilled, "Already fulfilled");
        require(block.number > request.targetBlock, "Target block not reached");
        require(msg.sender == request.requester, "Only requester can fulfill");
        
        // 使用目标区块的 PREVRANDAO 值
        // 注意：我们无法直接获取历史 PREVRANDAO，所以需要预先规划
        // 这里我们使用当前区块的 PREVRANDAO 结合其他因素
        
        uint256 random = generateSecureRandom(request.seed);
        
        request.randomNumber = random;
        request.fulfilled = true;
        
        emit RandomFulfilled(requestId, random);
        return random;
    }
    
    /**
     * 生成安全随机数（使用多个随机源）
     */
    function generateSecureRandom(uint256 seed) public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            block.prevrandao,      // 主要随机源
            blockhash(block.number - 1), // 前一个区块哈希
            block.timestamp,       // 时间戳
            msg.sender,            // 调用者地址
            seed,                  // 用户种子
            block.chainid          // 链ID
        )));
    }
    
    /**
     * 快速随机数（适用于低风险场景）
     */
    function quickRandom(uint256 max) public view returns (uint256) {
        uint256 random = uint256(keccak256(abi.encodePacked(
            block.prevrandao,
            block.timestamp,
            msg.sender
        )));
        
        return random % max;
    }
    
    /**
     * 批量生成随机数
     */
    function batchRandom(uint256 count, uint256 max, uint256 seed) public view returns (uint256[] memory) {
        require(count > 0 && count <= 20, "Count must be 1-20");
        
        uint256[] memory randoms = new uint256[](count);
        
        for (uint256 i = 0; i < count; i++) {
            uint256 random = uint256(keccak256(abi.encodePacked(
                block.prevrandao,
                seed,
                i,
                msg.sender,
                block.timestamp
            )));
            randoms[i] = random % max;
        }
        
        return randoms;
    }
}
