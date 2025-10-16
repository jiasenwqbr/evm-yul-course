// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MloadBasic {
    function basicMload() public pure returns(uint256 result) {
        assembly {
            // 1. 首先，我们需要在内存中存储一些数据
            // 使用 MSTORE(p, v)：在内存位置 `p` 存储32字节的值 `v`
            let valueToStore := 0x1234567890ABCDEF
            mstore(0x80,valueToStore)   // 将值存储在内存位置 0x80
            // 2. 现在，使用 MLOAD 从同一位置读取值
            result := mload(0x80)
            // 此时，result 的值应该是 0x1234567890ABCDEF
        }
    }
}