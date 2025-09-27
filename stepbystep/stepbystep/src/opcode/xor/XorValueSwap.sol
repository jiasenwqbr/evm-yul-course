// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract XorValueSwap {
    /**
     * @dev 使用 XOR 交换两个变量的值（无临时变量）
     */
    function swapWithXor(uint256 a,uint256 b) public pure returns(uint256,uint256) {
        assembly {
            let tempA := a
            let tempB := b
            tempA := xor(tempA, tempB)  // a = a ^ b
            tempB := xor(tempA, tempB)  // b = (a ^ b) ^ b = a
            tempA := xor(tempA, tempB)  // a = (a ^ b) ^ a = b
            
            a := tempA
            b := tempB
        }

        return (a,b);
    }

    /**
     * @dev 在存储中交换两个值（Gas 优化技巧）
     */
    function swapStorageValues(uint256 slot1, uint256 slot2) public {
        assembly {
            // 读取两个存储槽的值
            let value1 := sload(slot1)
            let value2 := sload(slot2)
            
            // 使用 XOR 交换
            value1 := xor(value1, value2)
            value2 := xor(value1, value2) 
            value1 := xor(value1, value2)
            
            // 写回存储
            sstore(slot1, value1)
            sstore(slot2, value2)
        }
    }
                
}
