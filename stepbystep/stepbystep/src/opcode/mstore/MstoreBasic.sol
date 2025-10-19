// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MstoreBasic {
    function basicMstore() public pure returns (uint256 result) {
        assembly {
            // 1. 使用 MSTORE 在内存位置 0x00 存储值
            let valueToStore := 0x1234567890ABCDEF
            mstore(0x00, valueToStore)
            
            // 2. 使用 MLOAD 验证存储的值
            result := mload(0x00) // result = 0x1234567890ABCDEF
            
            // 3. 覆盖写入
            let newValue := 0xFFFFFFFFFFFFFFFF
            mstore(0x00, newValue)
            
            // 现在位置 0x00 的值是 0xFFFFFFFFFFFFFFFF
        }
    }
}