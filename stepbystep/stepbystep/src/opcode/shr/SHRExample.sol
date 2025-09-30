// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SHRExample {
    function shiftRight(uint256 value, uint256 shift) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 从栈中依次取出 shift 和 value，进行右移操作
            // 语法：result := shr(shift, value)
            result := shr(shift, value)
        }
        return result;
    }

    // 一个更具体的例子：快速除以 2 的 n 次方
    function divideByPowerOfTwo(uint256 value, uint256 exponent) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 将 value 右移 exponent 位，等价于 value / (2^exponent)
            result := shr(exponent, value)
        }
        return result;
    }

    // 提取一个字节数组中的特定字节
    // 假设 `packed` 是一个将4个字节打包成的uint256： | byte3 | byte2 | byte1 | byte0 |
    function extractByte(uint256 packed, uint256 byteIndex) public pure returns (uint256) {
        require(byteIndex < 32, "Byte index out of range");
        uint256 result;
        assembly {
            // 1. 先将目标字节右移到最低位 (byteIndex * 8 位)
            // 2. 然后与 0xFF 进行 AND 操作来提取该字节
            result := and(shr(mul(byteIndex, 8), packed), 0xFF)
        }
        return result;
    }
}