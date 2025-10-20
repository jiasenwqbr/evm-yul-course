// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SstoreDataTypes {
    function storeDifferentTypes() public {
        assembly {
            // 存储 uint256
            sstore(0, 12345678901234567890)
            
            // 存储 address (右对齐，高位补零)
            let addr := 0x742d35Cc6634C0532925a3b8Dc23846f1cE8C7d3
            sstore(1, addr)
            
            // 存储 bool (1 = true)
            sstore(2, 1)
            
            // 存储 bytes32
            let data := "Hello Ethereum Storage!!!"
            sstore(3, data)
            
            // 存储多个值到连续存储槽
            sstore(4, 0x1111111111111111)
            sstore(5, 0x2222222222222222)
            sstore(6, 0x3333333333333333)
        }
    }
    
    function readStoredValues() public view returns (
        uint256,
        address, 
        bool,
        bytes32
    ) {
        assembly {
            let value1 := sload(0)
            let value2 := sload(1)
            let value3 := sload(2)
            let value4 := sload(3)
            
            mstore(0x00, value1)
            mstore(0x20, value2)
            mstore(0x40, value3)
            mstore(0x60, value4)
            return(0x00, 0x80)
        }
    }
}
