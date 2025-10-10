
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalldataLoadBasic {
    event Log(bytes4 selector, uint256 data, address sender);
    
    // 手动解析函数选择器
    function getFunctionSelector() public {
        bytes4 selector;
        assembly {
            // 从 calldata 偏移量 0 加载 32 字节
            // 然后右移 224 位 (32-4=28字节*8=224位) 获得前4字节
            selector := shr(0xe0, calldataload(0))
        }
        
        // 比较与 Solidity 内置的 msg.sig
        require(selector == msg.sig, "Selector mismatch");
        
        emit Log(selector, 0, msg.sender);
    }
    
    // 读取调用数据的不同部分
    function readCalldataParts() public view returns (
        bytes4 selector,
        uint256 first32Bytes,
        uint256 second32Bytes
    ) {
        assembly {
            // 读取函数选择器 (前4字节)
            selector := shr(0xe0, calldataload(0))
            
            // 读取第一个完整32字节 (偏移量0)
            first32Bytes := calldataload(0)
            
            // 读取第二个32字节 (偏移量32)
            second32Bytes := calldataload(0x20)
        }
        return (selector, first32Bytes, second32Bytes);
    }
    
    // 检查调用数据长度
    function checkCalldataLength() public view returns (uint256 length) {
        assembly {
            length := calldatasize()
        }
        return length;
    }
}