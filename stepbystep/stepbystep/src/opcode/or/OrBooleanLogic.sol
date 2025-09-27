// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrBooleanLogic {
     /**
     * @dev 逻辑或运算（多个条件中任意一个为真即返回真）
     */
    function logicalOr(bool a, bool b) public pure returns (bool) {
        bool result;
        assembly {
            // 将布尔值转换为 0/1，然后进行 OR 操作
            // 如果任一输入为真（非零），结果将为非零
            result := or(a, b)
        }
        return result;
    }
    
    /**
     * @dev 检查多个条件中是否至少有一个满足
     */
    function anyConditionMet(
        uint256 value,
        uint256 threshold1,
        uint256 threshold2,
        uint256 threshold3
    ) public pure returns (bool) {
        bool result;
        assembly {
            // 检查 value 是否大于任意一个阈值
            let cond1 := gt(value, threshold1)
            let cond2 := gt(value, threshold2) 
            let cond3 := gt(value, threshold3)
            
            // 使用 OR 组合所有条件
            result := or(or(cond1, cond2), cond3)
        }
        return result;
    }
    
    /**
     * @dev 复杂的条件组合：A AND (B OR C)
     */
    function complexCondition(bool A, bool B, bool C) public pure returns (bool) {
        bool result;
        assembly {
            // A && (B || C)
            let bOrC := or(B, C)
            result := and(A, bOrC)
        }
        return result;
    }
}