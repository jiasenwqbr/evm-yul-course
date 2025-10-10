// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicParameterValidation {
    event ValidationResult(bool isValid, uint256 expectedSize, uint256 actualSize, string message);
    
    // 验证固定参数函数的调用数据大小
    function validateFixedParams(uint256 a, address b, bytes32 c) public {
        uint256 actualSize;
        assembly {
            actualSize := calldatasize()
        }
        
        // 固定参数大小: 4(选择器) + 3 * 32(参数) = 100 字节
        uint256 expectedSize = 4 + 3 * 32;
        bool isValid = (actualSize == expectedSize);
        
        emit ValidationResult(isValid, expectedSize, actualSize, 
            isValid ? "Valid fixed parameters" : "Invalid parameter size");
        
        require(isValid, "Invalid calldata size for fixed parameters");
    }
    
    // 验证动态数组参数
    function validateDynamicArray(uint256[] memory array) public {
        uint256 actualSize;
        assembly {
            actualSize := calldatasize()
        }
        
        // 动态数组的最小大小: 4(选择器) + 32(数组偏移量) + 32(数组长度) = 68 字节
        uint256 minExpectedSize = 4 + 32 + 32;
        bool isValid = (actualSize >= minExpectedSize);
        
        if (isValid && array.length > 0) {
            // 加上数组元素的大小
            uint256 arrayDataSize = array.length * 32;
            isValid = (actualSize >= minExpectedSize + arrayDataSize);
        }
        
        emit ValidationResult(isValid, minExpectedSize, actualSize,
            isValid ? "Valid dynamic array" : "Invalid dynamic array size");
        
        require(isValid, "Invalid calldata size for dynamic array");
    }
    
    // 验证 bytes 参数
    function validateBytes(bytes memory data) public {
        uint256 actualSize;
        assembly {
            actualSize := calldatasize()
        }
        
        // bytes 的最小大小: 4(选择器) + 32(数据偏移量) + 32(数据长度) = 68 字节
        uint256 minExpectedSize = 4 + 32 + 32;
        bool isValid = (actualSize >= minExpectedSize);
        
        if (isValid && data.length > 0) {
            // 计算字节数据的实际大小（32字节对齐）
            uint256 dataSize = ((data.length + 31) / 32) * 32;
            isValid = (actualSize >= minExpectedSize + dataSize);
        }
        
        emit ValidationResult(isValid, minExpectedSize, actualSize,
            isValid ? "Valid bytes parameter" : "Invalid bytes parameter size");
        
        require(isValid, "Invalid calldata size for bytes parameter");
    }
    
    // 通用大小验证器
    function validateCalldataSize(uint256 minSize, uint256 maxSize) public view returns (bool) {
        uint256 size;
        assembly {
            size := calldatasize()
        }
        
        bool isValid = (size >= minSize && size <= maxSize);
        require(isValid, "Calldata size out of allowed range");
        
        return isValid;
    }
}
