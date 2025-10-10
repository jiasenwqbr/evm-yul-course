// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalldataCopyBasic {
    event CopyResult(bytes data, uint256 size);

    function copyFullCalldata() public {
        uint256 size;
        assembly {
            size := calldatasize()
        }

        bytes memory data = new bytes(size);

        assembly{
            // 复制整个调用数据到内存
            // destOffset: data + 0x20 (跳过长度字段)
            // offset: 0 (从调用数据开始)
            // length: size (整个调用数据大小)
            calldatacopy(add(data,0x20),0,size)
        }
        emit CopyResult(data,size);
    }

    // 比较 calldatacopy 和 Solidity 的 msg.data
    function compareMethods() public view returns (bool) {
        uint256 size;
        assembly {
            size := calldatasize()
        }
        
        // 方法1: 使用 calldatacopy
        bytes memory assemblyData = new bytes(size);
        assembly {
            calldatacopy(add(assemblyData, 0x20), 0, size)
        }
        
        // 方法2: 使用 Solidity 的 msg.data
        bytes memory solidityData = msg.data;
        
        // 比较结果
        return keccak256(assemblyData) == keccak256(solidityData);
    }
    
    // 复制函数选择器
    function copyFunctionSelector() public view returns (bytes4 selector) {
        bytes memory selectorData = new bytes(4);
        
        assembly {
            // 复制前4字节（函数选择器）
            calldatacopy(add(selectorData, 0x20), 0, 4)
            selector := mload(add(selectorData, 0x20))
        }
        
        return selector;
    } 
}
