// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MstoreArray {
    function createMemoryArray() public pure returns (uint256[] memory) {
        assembly {
            // 1. 在内存中分配数组空间
            // 数组布局: [length, element0, element1, ...]
            
            let arrLength := 3
            let arrPtr := 0x20 // 从空闲内存指针开始
            
            // 存储数组长度
            mstore(arrPtr, arrLength)
            
            // 存储数组元素
            mstore(add(arrPtr, 0x20), 100)  // arr[0]
            mstore(add(arrPtr, 0x40), 200)  // arr[1]
            mstore(add(arrPtr, 0x60), 300)  // arr[2]
            
            // 更新空闲内存指针 (Solidity 使用 0x40 位置存储空闲内存指针)
            mstore(0x40, add(arrPtr, 0x80))
            
            // 返回数组 (arrPtr 指向数组起始位置)
            return(arrPtr, 0x80) // 返回 4 * 32 = 128 (0x80) 字节
        }
    }

    
}