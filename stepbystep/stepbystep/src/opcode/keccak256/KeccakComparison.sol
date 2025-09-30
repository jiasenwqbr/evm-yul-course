// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KeccakComparison {
    // 使用 Solidity 内置的 keccak256 函数
    function solidityKeccak(bytes memory data) public pure returns (bytes32) {
        return keccak256(data);
    }
    
    // 使用 abi.encodePacked 然后哈希
    function packedKeccak(address addr, uint256 amount) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(addr, amount));
    }
    
    // 使用 abi.encode (会添加填充)
    function encodedKeccak(address addr, uint256 amount) public pure returns (bytes32) {
        return keccak256(abi.encode(addr, amount));
    }
    
    // 手动实现 packedKeccak
    function manualPackedKeccak(address addr, uint256 amount) public pure returns (bytes32) {
        bytes32 hash;
        assembly {
            // 在内存中构建数据
            mstore(0x00, addr)   // 注意：address 是 20 字节
            mstore(0x14, amount) // 在 0x14 位置存储 amount
            
            // 计算哈希：20 + 32 = 52 字节
            hash := keccak256(0x00, 0x34)
        }
        return hash;
    }
}