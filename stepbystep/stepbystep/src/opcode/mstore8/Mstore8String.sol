// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract Mstore8String {
    function buildString() public pure returns (string memory) {
        assembly {
            let str := "Hello, Ethereum!"
            let len := 17 // 字符串长度
            // 分配内存：长度字段(32字节) + 字符串数据
            let ptr := 0x20

            // 存储字符串长度
            mstore(ptr,len)

            // 逐个字符存储（使用 mstore8）
            for { let i := 0} lt (i,len) {i := add(i,1)} {
                // 获取字符串中的第i个字符
                let char := byte(i, str)
                // 存储到内存，注意偏移量计算
                mstore8(add(add(ptr,0x20),i),char)
            }
            // 更新空闲内存指针
            mstore(0x40, add(add(ptr, 0x20), len))

        }
    }
}