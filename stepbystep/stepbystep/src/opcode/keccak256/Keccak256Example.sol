// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Keccak256Example {
    function computeKeccak(bytes memory data) public pure returns (bytes32) {
        bytes32 hash;
        assembly {
            hash := keccak256(add(data,0x20),mload(data))
        }
        return hash;
    }
      // 计算两个值的拼接哈希
    function computeHashPair(uint256 a, uint256 b) public pure returns (bytes32) {
        bytes32 hash;
        assembly {
            // 在内存中准备数据
            // 将 a 存储在 0x00-0x20
            mstore(0x00, a)
            // 将 b 存储在 0x20-0x40
            mstore(0x20, b)
            // 计算从 0x00 开始，64 字节数据的哈希
            hash := keccak256(0x00, 0x40)
        }
        return hash;
    }

    // 模拟ecrecover的预编译地址的输入准备
    function getEthSignedMessageHash(bytes32 messageHash) public pure returns (bytes32) {
        bytes32 hash;
        assembly {
            // Ethereum signed message前缀
            mstore(0x00, 0x19457468657265756d205369676e6564204d6573736167653a0a333200000000) // "\x19Ethereum Signed Message:\n32"
            mstore(0x1b, messageHash) // 在0x1b位置存储messageHash
            
            // 计算从0x00开始，0x3b(59)字节数据的哈希
            hash := keccak256(0x00, 0x3b)
        }
        return hash;
    }
}


/**
 *  手动构造 EVM 字节码 
 我们来构造一个计算字符串 "hello" 哈希的字节码。
1.准备数据: 需要将 "hello" 放入内存
2.字节码序列:
    // 将 "hello" 的字节码放入内存
    PUSH6 0x68656c6c6f00    // "hello" + 00填充 (注意：需要32字节对齐)
    PUSH1 0x00
    MSTORE8                 // 在0x05位置存储最后一个字节

    PUSH5 0x68656c6c6f      // "hello" 
    PUSH1 0x00
    MSTORE                  // 在0x00位置存储"hello"

    // 现在内存布局：
    // 0x00: 68656c6c6f000000000000000000000000000000000000000000000000000000

    // 调用KECCAK256
    PUSH1 0x05              // length = 5 bytes ("hello")
    PUSH1 0x00              // offset = 0x00
    KECCAK256               // 计算哈希

    // 将结果存入存储
    PUSH1 0x00
    SSTORE

    STOP



 */