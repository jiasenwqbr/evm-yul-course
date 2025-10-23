
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PushSmallExample {
    function push2ForAddresses() public pure returns (uint256) {
        uint256 result;
        assembly {
            // PUSH2 用于较小的数值或地址部分
            let smallAddress := 0x1234
            result := smallAddress
        }
        return result;
    }
    
    function push4ForSelector() public view returns (bytes4) {
        bytes4 selector;
        assembly {
            // 函数选择器通常是 4 字节
            let transferSelector := 0xa9059cbb  // transfer(address,uint256)
            selector := transferSelector
            
            // 验证当前函数的选择器
            mstore(0x00, shl(224, calldataload(0)))
            let currentSelector := mload(0x00)
            
            // 比较选择器
            if eq(selector, currentSelector) {
                // 匹配处理
            }
        }
        return selector;
    }
    
    function push8ForTimestamps() public pure returns (uint256) {
        uint256 result;
        assembly {
            // PUSH8 可以表示时间戳或区块号
            let blockNumber := 0x00000000000186A0  // 100,000
            let timestamp1 := 0x0000000065F15AE0    // 大约 2023-09 的时间戳
            
            result := timestamp1
        }
        return result;
    }
    
    function pushVariousSizes() public pure returns (uint256[4] memory results) {
        assembly {
            // PUSH2: 16位值
            let value2 := 0x1234
            
            // PUSH4: 32位值  
            let value4 := 0x12345678
            
            // PUSH6: 48位值
            let value6 := 0x123456789ABC
            
            // PUSH8: 64位值
            let value8 := 0x123456789ABCDEF0
            
            // 存储结果
            mstore(add(results, 0x20), value2)
            mstore(add(results, 0x40), value4)
            mstore(add(results, 0x60), value6)
            mstore(add(results, 0x80), value8)
        }
        return results;
    }
}
