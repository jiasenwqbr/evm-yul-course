// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalldataSizeBasic {
    event SizeInfo(uint256 assemblySize, uint256 soliditySize, bool sizesMatch);
    
    // 使用内联汇编获取调用数据大小
    function getCalldataSizeAssembly() public view returns (uint256) {
        uint256 size;
        assembly {
            size := calldatasize()
        }
        return size;
    }
    
    // 比较汇编和 Solidity 的方式
    function compareSizeMethods() public view returns (uint256, uint256, bool) {
        uint256 assemblySize;
        uint256 soliditySize = msg.data.length;
        
        assembly {
            assemblySize := calldatasize()
        }
        
        bool sizesMatch = (assemblySize == soliditySize);
        return (assemblySize, soliditySize, sizesMatch);
    }
    
    // 记录大小信息
    function logSizeInfo() public {
        uint256 size;
        assembly {
            size := calldatasize()
        }
        
        emit SizeInfo(size, msg.data.length, size == msg.data.length);
    }
    
    // 检查最小调用数据大小
    function checkMinimumSize() public view returns (bool) {
        uint256 size;
        assembly {
            size := calldatasize()
        }
        
        // 即使是空调用，也至少有 4 字节（函数选择器）
        return size >= 4;
    }
}