// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract XorBitSetOperations {
    /**
     * @dev 查找集合中不同的元素（对称差集）
    */
    function symmetricDifference(
        uint256 setA, 
        uint256 setB
    ) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 对称差集 = (A ∪ B) - (A ∩ B) = A ^ B
            result := xor(setA, setB)
        }
        return result;
    }
    /**
     * @dev 检查两个集合是否不相交
     */
    function areDisjoint(
        uint256 setA, 
        uint256 setB
    ) public pure returns (bool) {
        bool result;
        assembly {
            // 如果不相交，A ∩ B = 0，所以 A & B = 0
            result := iszero(and(setA, setB))
        }
        return result;
    }

    /**
     * @dev 计算汉明距离（两个数不同的位数）
     */
    function hammingDistance(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 distance;
        assembly {
            let diff := xor(a, b)
            // 计算 diff 中1的个数（种群计数）
            distance := 0
            
            // 使用 Brian Kernighan 算法计算1的个数
            for {} iszero(iszero(diff)) {} {
                diff := and(diff, sub(diff, 1)) // 清除最低位的1
                distance := add(distance, 1)
            }
        }
        return distance;
    }
    
    /**
     * @dev 快速判断数字是否是2的幂（使用 XOR 技巧）
     */
    function isPowerOfTwo(uint256 x) public pure returns (bool) {
        bool result;
        assembly {
            // 2的幂的数只有一个位被设置
            // 技巧：x & (x - 1) == 0 且 x != 0
            let isNonZero := iszero(iszero(x))
            let isSingleBit := iszero(and(x, sub(x, 1)))
            result := and(isNonZero, isSingleBit)
            
            // 使用 XOR 的替代方法：x ^ (x - 1) == (2x - 1) 当 x 是2的幂时
            let xorCheck := xor(x, sub(x, 1))
            let alternativeCheck := eq(xorCheck, sub(shl(1, x), 1))
            result := and(result, alternativeCheck)
        }
        return result;
    }



}