// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssemblyMemory {
    function returnHello() external pure returns (string memory) {
         bytes memory b = new bytes(5);
         assembly{
            // 内存布局：b (pointer) 的第0个 32 bytes 存长度, 第32字节开始是数据
            let dataPtr := add(b,32)
            // 写入 32 字节，'hello' 左对齐（高位），因此需要填充
            mstore(dataPtr,0x68656c6c6f000000000000000000000000000000000000000000000000000000)
         }
         return string(b);
    }
}