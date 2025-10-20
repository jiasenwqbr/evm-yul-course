// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SstoreDynamicArrays {
    uint256[] public numbers;
    bytes32[] public dataArray;
    
    function initializeArray() public {
        assembly {
            // numbers 在存储槽 0
            // 设置数组长度
            sstore(0, 3) // 长度为 3
            
            // 计算数组元素起始位置
            mstore(0x00, 0) // 数组存储槽
            let arrayStart := keccak256(0x00, 0x20)
            
            // 存储数组元素
            sstore(arrayStart, 100)        // numbers[0]
            sstore(add(arrayStart, 1), 200) // numbers[1]
            sstore(add(arrayStart, 2), 300) // numbers[2]
        }
    }
    
    function pushToArray(uint256 newValue) public {
        assembly {
            // 读取当前长度
            let length := sload(0)
            
            // 计算新元素位置
            mstore(0x00, 0)
            let arrayStart := keccak256(0x00, 0x20)
            let newElementSlot := add(arrayStart, length)
            
            // 存储新元素
            sstore(newElementSlot, newValue)
            
            // 更新长度
            sstore(0, add(length, 1))
        }
    }
    
    function updateArrayElement(uint256 index, uint256 newValue) public {
        assembly {
            // 边界检查
            let length := sload(0)
            if gt(index, sub(length, 1)) {
                revert(0, 0)
            }
            
            // 计算元素位置
            mstore(0x00, 0)
            let arrayStart := keccak256(0x00, 0x20)
            let elementSlot := add(arrayStart, index)
            
            // 更新元素
            sstore(elementSlot, newValue)
        }
    }
}