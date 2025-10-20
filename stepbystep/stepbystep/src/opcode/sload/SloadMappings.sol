// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SloadMappings {
    mapping(uint256 => uint256) public simpleMap;
    mapping(address => uint256) public balances;
    uint256[] public dynamicArray;
    
    constructor() {
        simpleMap[42] = 0x1234567890ABCDEF;
        simpleMap[100] = 0xFFFFFFFFFFFFFFFF;
        
        balances[0x742d35Cc6634C0532925a3b8Dc23846f1cE8C7d3] = 1000 ether;
        
        dynamicArray.push(111);
        dynamicArray.push(222);
        dynamicArray.push(333);
    }
    
    function readMapping(uint256 key) public view returns (uint256 value,uint256 msolt) {
        assembly {
            // 映射存储位置计算: keccak256(key . slot)
            // slot 是映射变量声明的位置 (这里 simpleMap 在存储槽 0)
            mstore(0x00, key)
            mstore(0x20, 0) // 存储槽位置
            let mapSlot := keccak256(0x00, 0x40)
            
            value := sload(mapSlot)

            msolt := mapSlot
        }
    }
    
    function readAddressMapping(address addr) public view returns (uint256 balance) {
        assembly {
            // balances 在存储槽 1
            mstore(0x00, addr)
            mstore(0x20, 1) // 存储槽位置
            let balanceSlot := keccak256(0x00, 0x40)
            
            balance := sload(balanceSlot)
        }
    }
    
    function readDynamicArray(uint256 index) public view returns (uint256 element) {
        assembly {
            // dynamicArray 在存储槽 2
            // 数组长度在存储槽 2
            // 数组元素从 keccak256(2) 开始
            
            // 首先检查数组边界
            let length := sload(2)
            if gt(index, sub(length, 1)) {
                revert(0, 0)
            }
            
            // 计算元素位置: keccak256(2) + index
            mstore(0x00, 2) // 数组的存储槽
            let arrayStart := keccak256(0x00, 0x20)
            let elementSlot := add(arrayStart, index)
            
            element := sload(elementSlot)
        }
    }
}