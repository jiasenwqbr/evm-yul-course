// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ParityCheck {
    /**
     * @dev 检查数字是否为奇数
     * @param number 要检查的数字
     * @return 如果是奇数返回 true
     */
    function isOdd(uint256 number) public pure returns (bool) {
        bool result;
        uint256 tem = number;
        assembly {
            // 数字与 1 进行 AND 操作：
            // - 奇数：最低位为1，结果为1 → true
            // - 偶数：最低位为0，结果为0 → false
            result := and(tem, 1)
        }
        return result;
    }
    
    /**
     * @dev 检查数字是否为偶数
     * @param num 要检查的数字
     * @return 如果是偶数返回 true
     */
    function isEven(uint256 num) public pure returns (bool) {
        bool result;
        assembly {
            // 使用 iszero 来反转奇数的结果
            result := iszero(and(num, 1))
        }
        return result;
    }
}