// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressOpcodeExample {
    // 使用内联汇编获取合约地址
    function getAddressAssembly() public view returns (address) {
        address addr;
        assembly {
            addr := address()
        }
        return addr;
    }
    
    // 比较不同方式获取的地址
    function compareAddresses() public view returns (bool, bool) {
        address addrAssembly;
        assembly {
            addrAssembly := address()
        }
        
        address addrThis = address(this);
        
        return (addrAssembly == addrThis, addrAssembly == msg.sender);
    }
    
    // 在哈希计算中使用合约地址
    function computeContractHash() public view returns (bytes32) {
        bytes32 hash;
        assembly {
            // 将地址存入内存
            mstore(0x00, address())
            // 计算哈希（32字节）
            hash := keccak256(0x00, 0x20)
        }
        return hash;
    }
    
    // 检查调用者是否是合约自身（自检）
    function isSelfCall() public view returns (bool) {
        bool result;
        assembly {
            // 比较调用者是否是当前合约
            result := eq(caller(), address())
        }
        return result;
    }
}

/**
 * 手动构造 EVM 字节码
我们来构造一个简单的合约，它返回自己的地址。
// 获取合约地址
ADDRESS         // 0x30

// 将地址存入存储槽0
PUSH1 0x00      // 存储位置
SSTORE          // 存储地址

// 返回地址
PUSH1 0x20      // 返回数据长度 (32字节)
PUSH1 0x00      // 返回数据位置
RETURN



完整的字节码序列：0x3060005560206000f3

 */