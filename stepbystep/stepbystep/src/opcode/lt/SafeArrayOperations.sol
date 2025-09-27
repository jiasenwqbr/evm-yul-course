// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SafeArrayOperations {
    uint256[] public data;
    
    function initialize(uint256 size) public {
        data = new uint256[](size);
    }
    
    // 安全的数组访问（防止越界）
    function safeGet(uint256 index) public view returns (uint256) {
        // 使用 LT 进行边界检查
        bool isValidIndex;
        
        assembly {
            let arrayLength := sload(data.slot)
            isValidIndex := lt(index, arrayLength)
        }
        
        require(isValidIndex, "Index out of bounds");
        return data[index];
    }
    
    // 批量安全设置（汇编优化版）
    function batchSet(uint256[] memory indices, uint256[] memory values) public {
        require(indices.length == values.length, "Arrays length mismatch");
        
        assembly {
            let arrayLength := sload(data.slot)
            let indicesPtr := add(indices, 0x20)
            let valuesPtr := add(values, 0x20)
            
            for { let i := 0 } lt(i, mload(indices)) { i := add(i, 1) } {
                let index := mload(add(indicesPtr, mul(i, 0x20)))
                let value := mload(add(valuesPtr, mul(i, 0x20)))
                
                // 边界检查
                if iszero(lt(index, arrayLength)) {
                    // 索引越界，回滚
                    revert(0, 0)
                }
                
                // 计算存储位置并设置值
                let dataPtr := add(data.slot, 1) // 数组数据位置
                sstore(add(dataPtr, mul(index, 0x20)), value)
            }
        }
    }
    
    // 查找最小值
    function findMin() public view returns (uint256 minValue) {
        uint256 length = data.length;
        if (length == 0) return 0;
        
        minValue = type(uint256).max;
        
        assembly {
            let dataPtr := add(data.slot, 1) // 数组数据位置
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let currentValue := sload(add(dataPtr, mul(i, 0x20)))
                
                // 使用 LT 比较更新最小值
                if lt(currentValue, minValue) {
                    minValue := currentValue
                }
            }
        }
    }
}