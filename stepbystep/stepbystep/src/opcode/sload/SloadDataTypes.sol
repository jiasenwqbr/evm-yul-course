// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SloadDataTypes {
    uint256 public bigValue = 12345678901234567890;
    address public myAddress = 0x08aD141eadFC93cD4e1566c31E1fb49886D5b80B;
    bool public flag = true;
    bytes32 public data = "Hello Ethereum Storage";
    
    function readAllValues() public view returns (
        uint256,
        address,
        bool,
        bytes32
    ) {
        assembly {
            // 读取 uint256 (存储槽 0)
            let slot0 := sload(0)
            
            // 读取 address (存储槽 1) - address 在低20字节
            let slot1 := sload(1)
            // 清除高位只保留address
            let addr := and(slot1, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            
            // 读取 bool (存储槽 2) - bool 在最低字节
            let slot2 := sload(2)
            let flagValue := and(slot2, 0xFF)
            
            // 读取 bytes32 (存储槽 3)
            let slot3 := sload(3)
            
            // 返回结果
            mstore(0x00, slot0)
            mstore(0x20, addr)
            mstore(0x40, flagValue)
            mstore(0x60, slot3)
            return(0x00, 0x80)
        }
    }
}