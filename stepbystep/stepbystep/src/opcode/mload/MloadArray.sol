// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MloadArry {
    function readFromMemoryArray() public pure returns (uint256 elem1, uint256 elem2) {
        // 在Solidity中创建一个内存数组
        uint256[] memory arr = new uint256[](3);
        arr[0] = 100;
        arr[1] = 200;
        arr[2] = 300;

        assembly {
            // arr 变量本身是一个指针，指向数组在内存中的起始位置
            let arrPtr := arr

            // 读取数组长度（存储在 arrPtr 的位置）
            let length := mload(arrPtr) // length = 3

            // 读取第一个元素 (arr[0])
            // 元素从 arrPtr + 0x20 开始
            elem1 := mload(add(arrPtr, 0x20)) // elem1 = 100

            // 读取第二个元素 (arr[1])
            // 元素从 arrPtr + 0x40 开始
            elem2 := mload(add(arrPtr, 0x40)) // elem2 = 200

            // 读取第三个元素 (arr[2])： add(arrPtr, 0x60)
        }

    }
}

/**
 
Solidity 内存数组的结构
在 Solidity 中，当你创建一个 内存数组（uint256 ;）时，编译器在内存里为这个数组分配一个连续的区域：
| 偏移量 (相对 `arr`) | 内容               | 大小       |
| -------------- | ---------------- | -------- |
| `0x00`         | 数组长度（`length`）   | 32 bytes |
| `0x20`         | 第一个元素 (`arr[0]`) | 32 bytes |
| `0x40`         | 第二个元素 (`arr[1]`) | 32 bytes |
| `0x60`         | 第三个元素 (`arr[2]`) | 32 bytes |

arrPtr ─┬──────────────────────────
        │ [0x00] 数组长度 = 3
        │ [0x20] arr[0] = 100
        │ [0x40] arr[1] = 200
        │ [0x60] arr[2] = 300


 */