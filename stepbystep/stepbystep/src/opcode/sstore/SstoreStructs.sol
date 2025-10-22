// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SstoreStructs {
    struct User {
        uint256 id;
        address wallet;
        uint256 balance1;
        bool isActive;
    }
    
    User public currentUser;
    mapping(uint256 => User) public users;
    
    function storeUserStruct(
        uint256 id,
        address wallet,
        uint256 balance1,
        bool isActive
    ) public {
        assembly {
            // 结构体字段连续存储
            sstore(0, id)                    // currentUser.id
            sstore(1, wallet)                // currentUser.wallet
            sstore(2, balance1)               // currentUser.balance
            sstore(3, isActive)              // currentUser.isActive
        }
    }
    
    function storeUserInMapping(
        uint256 userId,
        uint256 id,
        address wallet, 
        uint256 balance1,
        bool isActive
    ) public {
        assembly {
            // 计算用户结构体起始位置
            mstore(0x00, userId)
            mstore(0x20, 4) // users 映射在存储槽 4
            let userStart := keccak256(0x00, 0x40)
            
            // 存储结构体字段
            sstore(userStart, id)                    // id
            sstore(add(userStart, 1), wallet)        // wallet
            sstore(add(userStart, 2), balance1)       // balance
            sstore(add(userStart, 3), isActive)      // isActive
        }
    }
    
    function updateUserBalance(uint256 userId, uint256 newBalance) public {
        assembly {
            mstore(0x00, userId)
            mstore(0x20, 4)
            let userStart := keccak256(0x00, 0x40)
            
            // 只更新 balance 字段 (存储槽 userStart + 2)
            sstore(add(userStart, 2), newBalance)
        }
    }
}