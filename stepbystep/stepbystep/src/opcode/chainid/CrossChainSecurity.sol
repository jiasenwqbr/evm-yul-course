// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CrossChainSecurity {
    struct SignedMessage {
        bytes32 messageHash;
        uint256 chainId;
        uint256 timestamp;
        address signer;
        bool executed;
    }
    
    mapping(bytes32 => SignedMessage) public signedMessages;
    mapping(address => uint256) public nonces;
    
    event MessageSigned(bytes32 indexed messageHash, address signer, uint256 chainId, uint256 nonce);
    event MessageExecuted(bytes32 indexed messageHash, address executor, bool success);
    
    /**
     * 创建链感知的消息哈希
     */
    function createMessageHash(
        address to,
        uint256 amount,
        bytes memory data,
        uint256 nonce
    ) public view returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            keccak256(abi.encodePacked(
                to,
                amount,
                data,
                nonce,
                block.chainid, // 包含链ID防止跨链重放
                address(this)
            ))
        ));
    }
    
    /**
     * 验证并执行签名消息
     */
    function executeSignedMessage(
        address to,
        uint256 amount,
        bytes memory data,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public returns (bool) {
        uint256 nonce = nonces[msg.sender];
        bytes32 messageHash = createMessageHash(to, amount, data, nonce);
        
        // 恢复签名者地址
        address signer = ecrecover(messageHash, v, r, s);
        require(signer != address(0), "Invalid signature");
        require(signer == msg.sender, "Not message signer");
        
        // 检查是否已执行
        require(!signedMessages[messageHash].executed, "Message already executed");
        
        // 记录签名消息
        signedMessages[messageHash] = SignedMessage({
            messageHash: messageHash,
            chainId: block.chainid,
            timestamp: block.timestamp,
            signer: signer,
            executed: true
        });
        
        nonces[msg.sender]++;
        
        // 执行消息（示例：转账）
        bool success = false;
        if (amount > 0) {
            (success, ) = to.call{value: amount}(data);
        } else {
            (success, ) = to.call(data);
        }
        
        emit MessageExecuted(messageHash, msg.sender, success);
        return success;
    }
    
    /**
     * 获取用户下一个nonce
     */
    function getNextNonce(address user) public view returns (uint256) {
        return nonces[user];
    }
    
    /**
     * 验证消息是否在指定链上有效
     */
    function verifyMessageChain(
        bytes32 messageHash,
        uint256 expectedChainId
    ) public view returns (bool) {
        SignedMessage storage message = signedMessages[messageHash];
        return message.chainId == expectedChainId && message.executed;
    }
}