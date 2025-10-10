// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomABIDecoder {
    // 事件用于调试
    event DecodingResult(uint256[] values, address[] addresses, bytes dynamicData);
    
    // 复杂参数结构解析
    function decodeComplexCall() public {
        // 假设调用格式: function(uint256[], address[], bytes)
        
        uint256[] memory uintArray;
        address[] memory addrArray;
        bytes memory dynamicBytes;
        
        assembly {
            let ptr := 0x04 // 跳过函数选择器
            
            // 解析 uint256[] - 第一个参数
            let uintArrayOffset := calldataload(ptr)
            ptr := add(ptr, 0x20)
            
            // 解析 address[] - 第二个参数
            let addrArrayOffset := calldataload(ptr)
            ptr := add(ptr, 0x20)
            
            // 解析 bytes - 第三个参数
            let bytesOffset := calldataload(ptr)
            
            // 解码 uint256[]
            let uintArrayLength := calldataload(add(0x04, uintArrayOffset))
            uintArray := mload(0x40)
            mstore(uintArray, uintArrayLength)
            let uintDataPtr := add(uintArray, 0x20)
            let uintCalldataPtr := add(0x04, add(uintArrayOffset, 0x20))
            
            for { let i := 0 } lt(i, uintArrayLength) { i := add(i, 1) } {
                mstore(uintDataPtr, calldataload(uintCalldataPtr))
                uintDataPtr := add(uintDataPtr, 0x20)
                uintCalldataPtr := add(uintCalldataPtr, 0x20)
            }
            
            // 解码 address[]
            let addrArrayLength := calldataload(add(0x04, addrArrayOffset))
            addrArray := uintDataPtr // 继续使用内存
            mstore(addrArray, addrArrayLength)
            let addrDataPtr := add(addrArray, 0x20)
            let addrCalldataPtr := add(0x04, add(addrArrayOffset, 0x20))
            
            for { let i := 0 } lt(i, addrArrayLength) { i := add(i, 1) } {
                mstore(addrDataPtr, and(calldataload(addrCalldataPtr), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF))
                addrDataPtr := add(addrDataPtr, 0x20)
                addrCalldataPtr := add(addrCalldataPtr, 0x20)
            }
            
            // 解码 bytes
            let bytesLength := calldataload(add(0x04, bytesOffset))
            dynamicBytes := addrDataPtr
            mstore(dynamicBytes, bytesLength)
            let bytesDataPtr := add(dynamicBytes, 0x20)
            let bytesCalldataPtr := add(0x04, add(bytesOffset, 0x20))
            
            // 复制字节数据
            for { let i := 0 } lt(i, bytesLength) { i := add(i, 0x20) } {
                mstore(bytesDataPtr, calldataload(bytesCalldataPtr))
                bytesDataPtr := add(bytesDataPtr, 0x20)
                bytesCalldataPtr := add(bytesCalldataPtr, 0x20)
            }
            
            // 处理非32字节对齐的情况
            let remaining := and(bytesLength, 0x1f)
            if gt(remaining, 0) {
                let mask := shl(mul(sub(0x20, remaining), 8), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                mstore(sub(bytesDataPtr, sub(0x20, remaining)), 
                       and(calldataload(sub(bytesCalldataPtr, sub(0x20, remaining))), mask))
            }
            
            // 更新空闲内存指针
            mstore(0x40, add(dynamicBytes, and(add(add(bytesLength, 0x20), 0x1f), not(0x1f))))
        }
        
        emit DecodingResult(uintArray, addrArray, dynamicBytes);
    }
    
    // 获取完整的调用数据十六进制表示
    function getFullCalldataHex() public view returns (bytes memory) {
        bytes memory data;
        
        assembly {
            let length := calldatasize()
            data := mload(0x40)
            mstore(data, length)
            
            // 复制整个调用数据到内存
            calldatacopy(add(data, 0x20), 0, length)
            
            // 更新空闲内存指针
            mstore(0x40, add(data, and(add(length, 0x3f), not(0x1f))))
        }
        
        return data;
    }
}