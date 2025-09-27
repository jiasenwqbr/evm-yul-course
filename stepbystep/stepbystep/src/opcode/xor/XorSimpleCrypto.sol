// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract XorSimpleCrypto {
    /**
     * @dev 使用密钥对数据进行加密
     * @param data 要加密的数据
     * @param key 加密密钥
     * @return encrypted 加密后的数据
     */
    function encrypt(uint256 data, uint256 key) public pure returns (uint256) {
        uint256 encrypted;
        assembly {
            encrypted := xor(data, key)
        }
        return encrypted;
    }
    
    /**
     * @dev 使用相同的密钥对数据进行解密
     * @param encrypted 加密的数据
     * @param key 解密密钥（与加密密钥相同）
     * @return decrypted 解密后的数据
     */
    function decrypt(uint256 encrypted, uint256 key) public pure returns (uint256) {
        uint256 decrypted;
        assembly {
            // 利用 XOR 的自反性：data ^ key ^ key = data
            decrypted := xor(encrypted, key)
        }
        return decrypted;
    }
    
    /**
     * @dev 使用多个密钥进行更复杂的加密
     */
    function encryptWithMultipleKeys(
        uint256 data, 
        uint256[] memory keys
    ) public pure returns (uint256) {
        uint256 result = data;
        assembly {
            let length := mload(keys)
            let keysPtr := add(keys, 0x20)
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let key := mload(add(keysPtr, mul(i, 0x20)))
                result := xor(result, key)
            }
        }
        return result;
    }


}