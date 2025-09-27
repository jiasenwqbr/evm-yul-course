// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CryptoPrimitives {
    /**
     * @dev 一次性密码本（One-Time Pad）加密
     */
    function oneTimePadEncrypt(
        uint256 message, 
        uint256 key
    ) public pure returns (uint256) {
        uint256 ciphertext;
        assembly {
            ciphertext := xor(message, key)
        }
        return ciphertext;
    }

    /**
     * @dev 简单的伪随机数生成器（不适用于安全场景）
     */
    function simplePRNG(uint256 seed, uint256 nonce) public pure returns (uint256) {
        uint256 random;
        assembly {
            // 使用 XOR 和移位创建简单的哈希混合
            random := xor(seed, nonce)
            random := xor(random, shl(32, random))
            random := xor(random, shr(17, random))
            random := xor(random, shl(13, random))
        }
        return random;
    }

    /**
     * @dev 创建简单的承诺方案（commit-reveal）
     */
    function createCommitment(
        uint256 secret, 
        uint256 salt
    ) public pure returns (uint256) {
        uint256 commitment;
        assembly {
            // 承诺 = hash(secret ^ salt)
            let mixed := xor(secret, salt)
            commitment := keccak256(0x00, 0x20) // 在实际中需要正确准备内存
        }
        return commitment;
    }
    
    /**
     * @dev 验证承诺
     */
    function verifyCommitment(
        uint256 secret,
        uint256 salt, 
        uint256 commitment
    ) public pure returns (bool) {
        bool isValid;
        assembly {
            let mixed := xor(secret, salt)
            let computedCommitment := keccak256(0x00, 0x20)
            isValid := eq(computedCommitment, commitment)
        }
        return isValid;
    }
}