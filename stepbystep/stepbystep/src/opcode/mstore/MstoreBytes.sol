// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MstoreBytes {
    function createBytes() public pure returns (bytes memory) {
        assembly {
            // 要存储的字节数据
            let data := 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF
            
            // 计算需要的内存空间
            let dataLength := 24 // 24字节 (0x18)
            let totalSize := add(0x20, 0x20) // 长度字段(0x20) + 数据(0x20)
            
            let ptr := 0x20
            
            // 存储长度
            mstore(ptr, dataLength)
            
            // 存储数据 (数据在低24字节，高位会自动补0)
            mstore(add(ptr, 0x20), data)
            
            // 更新空闲内存指针
            mstore(0x40, add(ptr, totalSize))
            
            return(ptr, totalSize)
        }
    }
    
    function createString() public pure returns (string memory) {
        assembly {
            // 字符串 "Hello Ethereum"
            let ptr := 0x20
            
            // 存储字符串长度 (14个字符)
            mstore(ptr, 14)
            
            // 存储字符串数据 (每个字符1字节)
            // 前32字节: "Hello Ethereum"
            mstore(add(ptr, 0x20), 0x48656c6c6f20457468657265756d000000000000000000000000000000000000)
            
            // 更新空闲内存指针
            mstore(0x40, add(ptr, 0x40))
            
            return(ptr, 0x40)
        }
    }
}