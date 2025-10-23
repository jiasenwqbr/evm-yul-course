
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PushMediumExample {
    function push16ForPartialHash() public pure returns (bytes16) {
        bytes16 result;
        assembly {
            // PUSH16 用于哈希值的前半部分
            let partialHash := 0x1234567890ABCDEF1234567890ABCDEF
            result := partialHash
        }
        return result;
    }
    
    function push20ForAddress() public pure returns (address) {
        address addr;
        assembly {
            // PUSH20 用于完整的以太坊地址
            let testAddress := 0x1234567890123456789012345678901234567890
            addr := testAddress
        }
        return addr;
    }
    
    function push24ForLargeValues() public pure returns (uint256) {
        uint256 result;
        assembly {
            // PUSH24 可以表示很大的数值
            let largeValue := 0x1234567890ABCDEF1234567890ABCDEF1234567890AB
            result := largeValue
        }
        return result;
    }
    
    function addressOperations() public pure returns (bool) {
        bool result;
        assembly {
            // 使用 PUSH20 进行地址比较
            let address1 := 0x1111111111111111111111111111111111111111
            let address2 := 0x2222222222222222222222222222222222222222
            
            result := eq(address1, address2)  // 返回 false
        }
        return result;
    }
}
