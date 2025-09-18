// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyStorage {
    mapping(address => uint256) public balances; // balances.slot 可在 assembly 中用 balances.slot
    
    function setBalAsm(address who,uint256 val) external {
        assembly{
            // 把 key 放到内存 0x0，slot 放到 0x20，然后 keccak256
            // 步骤1: 将key(address)存入内存0x00位置
            mstore(0x0,who)                     // 内存布局: [0x00-0x1F]: who
                                                // who = 0x1234... (20字节，右对齐)
            // 步骤2: 将映射的slot号存入内存0x20位置  
            // [0x20-0x3F]: balances.slot
            mstore(0x20,balances.slot)   // 重要：balances.slot 是由编译器生成并可在 assembly 中引用（更稳妥比手工猜 slot 好）。// balances.slot 是编译器生成的常量
            // 步骤3: 计算实际存储位置
            let h := keccak256(0x0,0x40)        // 对64字节数据(0x00-0x3F)进行哈希   // h = keccak256(who . balances.slot)
             // 步骤4: 将值存储到计算出的位置
            sstore(h,val)        // 在存储位置h存储值val
        }
    }

    function getBalAsm(address who) external view returns (uint256 val) {
        assembly {
            mstore(0x0, who)
            mstore(0x20, balances.slot)
            let h := keccak256(0x0, 0x40)
            // 从计算出的位置读取值
            val := sload(h)     // 从存储位置h读取值到val
        }
    }
}