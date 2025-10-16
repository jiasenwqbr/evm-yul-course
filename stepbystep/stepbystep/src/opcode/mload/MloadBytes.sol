// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MloadBytes {
    function readBytes() public pure returns (bytes32 part1, uint256 len) {
        // bytes memory data1 = hex"1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000";

        bytes memory data = abi.encodePacked(
            hex"1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000"
        );

        assembly {
            let dataPtr := data

            // 1. 读取数据的长度（以字节为单位）
            len := mload(dataPtr) // len = 24 (0x18)，因为3*8=24字节

            // 2. 读取前32字节的数据内容
            // 注意：虽然数据只有24字节，但mload会读取32字节，超出的部分为0
            part1 := mload(add(dataPtr, 0x20))

            // part1 的值将是：
            // 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000
            // 注意末尾的0，因为原始数据不足32字节
        }
    }

    function readBytes2() public pure returns (bytes32 part1, bytes32 part2,uint256 len) {
        // bytes memory data1 = hex"1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000";

        bytes memory data = abi.encodePacked(
            hex"1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000"
        );

        assembly {
            let dataPtr := data

            // 1. 读取数据的长度（以字节为单位）
            len := mload(dataPtr) // len = 24 (0x18)，因为3*8=24字节

            // 2. 读取前32字节的数据内容
            // 注意：虽然数据只有24字节，但mload会读取32字节，超出的部分为0
            part1 := mload(add(dataPtr, 0x20))

            // part1 的值将是：
            // 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF0000000000000000
            // 注意末尾的0，因为原始数据不足32字节
            part2 := mload(add(dataPtr,0x40))
        }
    }
}


/**
 * 
 * hex 的作用：定义十六进制字节常量
✅ 基本作用

在 Solidity 中，hex"..." 是一种 字节面量（bytes literal），
用于直接写入原始的十六进制字节数据，而不是字符串。

    每两个 hex 字符代表 1 个字节。
    所以 hex"AB" → 长度 1
    hex"ABCD" → 长度 2
    hex"1234567890" → 长度 5
    ⚠️ 你必须保证字符数是偶数，否则编译器会报错：
 */