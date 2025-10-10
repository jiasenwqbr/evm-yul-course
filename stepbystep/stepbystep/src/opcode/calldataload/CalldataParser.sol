
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalldataParser {
    // 解析单个 uint256 参数
    function parseUint256(uint256 offset) public pure returns (uint256 value) {
        assembly {
            value := calldataload(offset)
        }
    }
    
    // 解析单个 address 参数
    function parseAddress(uint256 offset) public pure returns (address addr) {
        assembly {
            // address 是 20 字节，需要从 32 字节中提取
            addr := and(calldataload(offset), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
        }
    }
    
    // 解析单个 bytes32 参数
    function parseBytes32(uint256 offset) public pure returns (bytes32 value) {
        assembly {
            value := calldataload(offset)
        }
    }
    
    // 解析 bytes 动态数据
    function parseBytes(uint256 offset) public pure returns (bytes memory data) {
        assembly {
            // bytes 在 calldata 中的布局:
            // offset: 数据长度
            // offset + 0x20: 实际数据
            
            let length := calldataload(offset)
            
            // 分配内存
            data := mload(0x40)
            mstore(data, length)
            
            // 计算数据位置
            let dataPtr := add(data, 0x20)
            let calldataPtr := add(offset, 0x20)
            
            // 复制数据 (按32字节块)
            for { let i := 0 } lt(i, length) { i := add(i, 0x20) } {
                mstore(dataPtr, calldataload(calldataPtr))
                dataPtr := add(dataPtr, 0x20)
                calldataPtr := add(calldataPtr, 0x20)
            }
            
            // 处理剩余字节
            let remaining := and(length, 0x1f)
            if gt(remaining, 0) {
                let mask := shl(mul(sub(0x20, remaining), 8), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                mstore(sub(dataPtr, sub(0x20, remaining)), 
                       and(calldataload(sub(calldataPtr, sub(0x20, remaining))), mask))
            }
            
            // 更新空闲内存指针
            mstore(0x40, add(data, and(add(length, 0x3f), not(0x1f))))
        }
    }
    
    // 批量解析多个参数
    function parseMultipleParams() public pure returns (
        uint256 param1,
        address param2,
        bytes32 param3,
        uint256 param4
    ) {
        assembly {
            param1 := calldataload(0x04)  // 第一个参数

            // param2 := address(calldataload(0x24)) // 第二个参数
            let raw := calldataload(0x24)
            param2 := and(raw, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            param3 := calldataload(0x44)  // 第三个参数
            param4 := calldataload(0x64)  // 第四个参数
        }
    }
}