// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SltRangeCheck {
    /**
     * @dev 检查一个有符号整数是否在 [-100, 100] 区间内。
     * @param _value 要检查的值
     * @return 如果在范围内返回 true，否则 false
     */
    function isInRange(int256 _value) public pure returns (bool) {
        bool result;
        assembly {
            // 检查需要同时满足两个条件：
            // 1. -100 <= _value
            // 2. _value <= 100

            // 条件1: -100 <= _value 等价于 _value >= -100
            // 用 slt 表示： 不能是 _value < -100
            let condition1 := iszero(slt(_value, sub(0,100)))

            // 条件2: _value <= 100 等价于 不能是 100 < _value
            // 用 slt 表示： 不能是 slt(100, _value) 为真
            let condition2 := iszero(slt(100, _value))

            // 如果 condition1 和 condition2 都为真（非零），则 result = 1
            result := and(condition1, condition2)
        }
        return result;
    }
}