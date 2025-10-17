// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MloadStruct {
    struct MyStruct {
        uint256 a;
        uint256 b;
        address c;
    }

    function loadStructFields(MyStruct memory s) public pure returns (uint256, uint256, address) {
        assembly {
            // s 是指向结构体内存起始位置的指针
            // 字段 a 在偏移量 0
            let a := mload(s)

            // 字段 b 在偏移量 0x20
            let b := mload(add(s, 0x20))

            // 字段 c (address) 在偏移量 0x40
            // 但address只有20字节，所以我们需要处理
            let cBytes := mload(add(s, 0x40))
            // 由于mload读取32字节，而address在低20字节，我们需要清除高位
            // let c := and(cBytes, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)

            // 返回结果
            mstore(0x80, a)
            mstore(0xA0, b)
            mstore(0xC0, cBytes)
            return(0x80, 0x60) // 返回 3 * 32 = 96 (0x60) 字节
        }
    }
}