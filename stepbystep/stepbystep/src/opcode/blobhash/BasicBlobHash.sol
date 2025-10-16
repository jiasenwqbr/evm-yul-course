// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicBlobHash {
    /**
     * 使用内联汇编获取 blob 哈希
     */
    function getBlobHash(uint256 index) public view returns (bytes32) {
        bytes32 hash;
        assembly {
            hash := blobhash(index)
        }
        return hash;
    }
    
    /**
     * 获取所有可用的 blob 哈希
     */
    function getAllBlobHashes() public view returns (bytes32[] memory) {
        // 初始限制为 6 个 blob
        bytes32[] memory hashes = new bytes32[](6);
        
        for (uint256 i = 0; i < 6; i++) {
            bytes32 hash;
            assembly {
                hash := blobhash(i)
            }
            hashes[i] = hash;
        }
        
        return hashes;
    }
    
    /**
     * 检查特定索引的 blob 是否存在
     */
    function blobExists(uint256 index) public view returns (bool) {
        bytes32 hash;
        assembly {
            hash := blobhash(index)
        }
        // 如果哈希为零，表示该索引的 blob 不存在
        return hash != bytes32(0);
    }
    
    /**
     * 获取有效的 blob 数量
     */
    function getBlobCount() public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i < 6; i++) {
            if (blobExists(i)) {
                count++;
            }
        }
        return count;
    }
}