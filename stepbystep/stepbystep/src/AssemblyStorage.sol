// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyStorage {
    mapping(address => uint256) public balances; // balances.slot 可在 assembly 中用 balances.slot
    
    function setBalAsm(address who,uint256 val) external {
        assembly{
            // 把 key 放到内存 0x0，slot 放到 0x20，然后 keccak256
            mstore(0x0,who)
            mstore(0x20,balances.slot)   // 重要：balances.slot 是由编译器生成并可在 assembly 中引用（更稳妥比手工猜 slot 好）。
            let h := keccak256(0x0,0x40)
            sstore(h,val)
        }
    }

    function getBalAsm(address who) external view returns (uint256 val) {
        assembly {
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            val := sload(h)
        }
    }
}