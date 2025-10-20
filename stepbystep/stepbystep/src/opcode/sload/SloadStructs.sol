// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SloadStructs {
    struct User {
        uint256 id;
        address wallet;
        uint256 balance;
        bool isActive;
    }
    
    User public currentUser = User({
        id: 1,
        wallet: 0x742d35Cc6634C0532925a3b8Dc23846f1cE8C7d3,
        balance: 1000 ether,
        isActive: true
    });
    
    mapping(uint256 => User) public users;
    
    constructor() {
        users[100] = User({
            id: 100,
            wallet: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
            balance: 500 ether,
            isActive: false
        });
    }
    
    function readStruct() public view returns (uint256, address, uint256, bool) {
        assembly {
            // 结构体在存储中连续存储
            // 存储槽 0: id
            let id := sload(0)
            
            // 存储槽 1: wallet (address在低20字节)
            let walletSlot := sload(1)
            let wallet := and(walletSlot, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            
            // 存储槽 2: balance
            let balance := sload(2)
            
            // 存储槽 3: isActive (bool在最低字节)
            let isActiveSlot := sload(3)
            let isActive := and(isActiveSlot, 0xFF)
            
            mstore(0x00, id)
            mstore(0x20, wallet)
            mstore(0x40, balance)
            mstore(0x60, isActive)
            return(0x00, 0x80)
        }
    }
    
    function readUserFromMapping(uint256 userId) public view returns (uint256, address, uint256, bool) {
        assembly {
            // users 映射在存储槽 4
            // 计算 User 结构体的起始存储位置
            mstore(0x00, userId)
            mstore(0x20, 4) // 映射的存储槽
            let userStart := keccak256(0x00, 0x40)
            
            // 读取结构体字段
            let id := sload(userStart)           // id
            let walletSlot := sload(add(userStart, 1)) // wallet
            let wallet := and(walletSlot, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            let balance := sload(add(userStart, 2))    // balance
            let isActiveSlot := sload(add(userStart, 3)) // isActive
            let isActive := and(isActiveSlot, 0xFF)
            
            mstore(0x00, id)
            mstore(0x20, wallet)
            mstore(0x40, balance)
            mstore(0x60, isActive)
            return(0x00, 0x80)
        }
    }
}