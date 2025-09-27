// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract XorParityCheck {
    /**
     * @dev 计算数据的奇偶校验位（1的个数为奇数返回1，偶数返回0）
     * @param data 要计算的数据
     * @return parity 奇偶校验位
     */
    function calculateParity(uint256 data) public pure returns (uint256) {
        uint256 parity;
        assembly {
            // 使用 XOR 折叠法计算奇偶性
            // 将256位数据不断对半异或，最后得到奇偶位
            
            let x := data
            x := xor(x, shr(1, x))   // 折叠2位
            x := xor(x, shr(2, x))   // 折叠4位
            x := xor(x, shr(4, x))   // 折叠8位
            x := xor(x, shr(8, x))   // 折叠16位
            x := xor(x, shr(16, x))  // 折叠32位
            x := xor(x, shr(32, x))  // 折叠64位
            x := xor(x, shr(64, x))  // 折叠128位
            x := xor(x, shr(128, x)) // 折叠256位
            
            // 取最低位作为奇偶校验位
            parity := and(x, 1)
        }
        return parity;
    }

    /**
     * @dev 计算简单的校验和（所有字节异或）
     */
    function simpleChecksum(bytes memory data) public pure returns (uint256) {
        uint256 checksum;
        assembly {
            let length := mload(data)
            let dataPtr := add(data, 0x20)
            checksum := 0
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let byteValue := and(mload(add(dataPtr, i)), 0xFF)
                checksum := xor(checksum, byteValue)
            }
        }
        return checksum;
    }
    
    /**
     * @dev 检查两个数据块是否完全相同
     */
    function areEqual(bytes memory a, bytes memory b) public pure returns (bool) {
        bool result;
        assembly {
            let lengthA := mload(a)
            let lengthB := mload(b)
            
            // 如果长度不同，直接返回 false
            if iszero(eq(lengthA, lengthB)) {
                result := 0
                // leave
            }
            
            let ptrA := add(a, 0x20)
            let ptrB := add(b, 0x20)
            let diff := 0
            
            // 比较每个字节，使用 XOR 检测差异
            for { let i := 0 } lt(i, lengthA) { i := add(i, 0x20) } {
                let chunkA := mload(add(ptrA, i))
                let chunkB := mload(add(ptrB, i))
                diff := or(diff, xor(chunkA, chunkB))
            }
            
            result := iszero(diff) // 如果所有 XOR 结果都是0，则数据相同
        }
        return result;
    }






}