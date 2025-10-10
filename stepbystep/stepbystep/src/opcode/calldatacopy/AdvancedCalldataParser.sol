// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedCalldataParser {
     event ParameterParsed(uint256 index, bytes data, address parsedAddress);
    
    // 手动解析动态数组参数
    function parseDynamicArray() public {
        // 假设函数签名: function parseDynamicArray(uint256[] memory array)
        uint256 arrayOffset;
        uint256 arrayLength;
        bytes memory arrayData;

        assembly {
            // 读取数组偏移量（在0x04位置）
            arrayOffset := calldataload(0x04)
            // 读取数组长度（在arrayOffset + 0x04位置）
            arrayLength := calldataload(add(0x04, arrayOffset))
            // 分配内存存储数组数据
            arrayData := mload(0x40)
            mstore(arrayData, arrayLength) // 存储数组长度

            // 计算数组数据在calldata中的位置
            let calldataPtr := add(0x04, add(arrayOffset, 0x20))
            let memPtr := add(arrayData, 0x20)
            let dataSize := mul(arrayLength, 0x20)
            // 使用calldatacopy复制整个数组数据
            calldatacopy(memPtr, calldataPtr, dataSize)
            
            // 更新空闲内存指针
            mstore(0x40, add(memPtr, dataSize))
        }
        // 现在arrayData包含完整的数组数据
        emit ParameterParsed(0, arrayData, msg.sender);
    }

    // 解析bytes动态参数
    function parseBytesParameter() public view returns (bytes memory result) {
        assembly {
            // 假设bytes参数是第一个参数
            let offset := calldataload(0x04) // bytes数据的偏移量
            let length := calldataload(add(0x04, offset)) // bytes长度
            
            // 分配内存
            result := mload(0x40)
            mstore(result, length)
            
            // 复制bytes数据
            let calldataPtr := add(0x04, add(offset, 0x20))
            calldatacopy(add(result, 0x20), calldataPtr, length)
            
            // 更新空闲内存指针（32字节对齐）
            mstore(0x40, add(add(result, 0x20), and(add(length, 0x1f), not(0x1f))))
        }
    }
    
    // 批量解析多个参数
    function batchParseParameters() public view returns (
        bytes4 selector,
        uint256 param1,
        address param2,
        bytes32 param3
    ) {
        assembly {
            // 复制函数选择器
            selector := shr(0xe0, calldataload(0))
            
            // 复制第一个uint256参数
            param1 := calldataload(0x04)
            
            // 复制address参数（需要掩码）
            param2 := and(calldataload(0x24), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            
            // 复制bytes32参数
            param3 := calldataload(0x44)
        }
    }




}