// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Push1Example {
    function push1Basic() public pure returns (uint256) {
        uint256 result;
        assembly {
            // 压入各种 1 字节值
            // 0x01           // 数字 1
            // 0xFF           // 数字 255
            // 0x00           // 数字 0 (不如 PUSH0 高效)
            // 0x80           // 128
            
            // 使用这些值进行计算
            let a := 0x10  // 16
            let b := 0x02  // 2
            result := mul(a, b)  // 32
        }
        return result;
    }

    function push1ForBitmask() public pure returns (uint256) {
        uint256 result;
        assembly {
            // 创建位掩码
            let mask := 0x01  // 二进制: 00000001
            let value := 0x05 // 二进制: 00000101
            
            // 检查最低位是否设置
            result := and(value, mask)  // 结果: 1
        }
        return result;
    }
}