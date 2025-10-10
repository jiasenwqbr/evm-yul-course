
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ManualParameterParsing {
    event ParamsDecoded(uint256 param1, address param2, bytes32 param3);
    
    // 模拟函数: myFunction(uint256, address, bytes32)
    // 函数选择器: 0x6d2c8f7e (前8个字符的keccak256哈希)
    function myFunction(uint256, address, bytes32) public {
        // 正常函数实现
    }
    
    // 手动解析参数的版本
    function manualParse() public {
        uint256 param1;
        address param2;
        bytes32 param3;
        
        assembly {
            // 跳过函数选择器 (4字节)，读取第一个参数
            param1 := calldataload(0x04)
            
            // 读取第二个参数 (偏移量 0x24 = 4 + 32)
            // 转换为 address (取右20字节)
            // param2 := address(calldataload(0x24))

            let raw := calldataload(0x24)
            // 清掉高 12 字节，只保留低 20 字节
            raw := and(raw, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            // 存到 param2
            param2 := raw
            
            // 读取第三个参数 (偏移量 0x44 = 4 + 32 + 32)
            param3 := calldataload(0x44)
        }
        
        emit ParamsDecoded(param1, param2, param3);
    }
    
    // 动态数组参数解析
    function parseDynamicArray() public pure returns (uint256[] memory) {
        uint256[] memory arr;
        
        assembly {
            // 动态数组在 calldata 中的布局:
            // 偏移量 0x04: 数组数据的偏移量 (通常是 0x20)
            // 偏移量 0x24: 数组长度
            // 偏移量 0x44: 数组元素开始
            
            let offset := calldataload(0x04) // 数组数据偏移量
            let length := calldataload(add(0x04, offset)) // 数组长度
            
            // 分配内存空间
            arr := mload(0x40)
            mstore(arr, length) // 存储数组长度
            
            // 复制数组数据
            let dataPtr := add(arr, 0x20)
            let calldataPtr := add(0x04, add(offset, 0x20))
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                mstore(dataPtr, calldataload(calldataPtr))
                dataPtr := add(dataPtr, 0x20)
                calldataPtr := add(calldataPtr, 0x20)
            }
            
            // 更新空闲内存指针
            mstore(0x40, dataPtr)
        }
        
        return arr;
    }
}