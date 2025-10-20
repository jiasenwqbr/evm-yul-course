// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SstoreMappings {
    mapping(uint256 => uint256) public simpleMap;
    mapping(address => uint256) public balances;
    
    function storeInMapping(uint256 key, uint256 value) public {
        assembly {
            // 计算映射存储位置: keccak256(key . slot)
            // simpleMap 在存储槽 0
            mstore(0x00, key)
            mstore(0x20, 0) // 存储槽位置
            let mapSlot := keccak256(0x00, 0x40)
            
            sstore(mapSlot, value)
        }
    }
    
    function storeAddressMapping(address user, uint256 balance) public {
        assembly {
            // balances 在存储槽 1
            mstore(0x00, user)
            mstore(0x20, 1) // 存储槽位置
            let balanceSlot := keccak256(0x00, 0x40)
            
            sstore(balanceSlot, balance)
        }
    }
    
    function batchUpdateBalances(
        address[] calldata users,
        uint256[] calldata newBalances
    ) public {
        require(users.length == newBalances.length, "Length mismatch");
        
        assembly {
            for { let i := 0 } lt(i, users.length) { i := add(i, 1) } {
                // 获取用户地址和余额
                let user := calldataload(add(users.offset, mul(i, 0x20)))
                let balance := calldataload(add(newBalances.offset, mul(i, 0x20)))
                
                // 计算存储位置
                mstore(0x00, user)
                mstore(0x20, 1) // balances 存储槽
                let slot := keccak256(0x00, 0x40)
                
                // 更新余额
                sstore(slot, balance)
            }
        }
    }
}
