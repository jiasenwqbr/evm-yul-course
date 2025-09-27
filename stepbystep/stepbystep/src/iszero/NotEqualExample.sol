// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract NotEqualExample {
    /**
     * @dev 检查两个值是否不相等。
     * @param a 第一个值
     * @param b 第二个值
     * @return 如果 a != b 返回 true
     */
    function notEqual(uint256 a, uint256 b) public pure returns (bool) {
        bool result;
        assembly {
            // 等价于 a != b
            // 先检查是否相等，然后对结果取反
            result := iszero(eq(a, b))
        }
        return result;
    }
    
    /**
     * @dev 检查有符号数 a 是否不小于等于 b（即 a > b）。
     * 因为 EVM 没有 sgt（有符号大于）操作码，需要用 iszero(slt(a, b)) 实现。
     */
    function signedGreaterThan(int256 a, int256 b) public pure returns (bool) {
        bool result;
        assembly {
            // "a > b" 等价于 "不是 (a <= b)"，而 "a <= b" 等价于 "a < b 或 a == b"
            // 更简单的方式：a > b 等价于 !(a <= b)，而 a <= b 可以用 slt(b, a) 判断？
            // 正确逻辑：a > b 等价于 !(a <= b) 等价于 !slt(a, b) 但要注意边界情况
            // 最安全：a > b 等价于 slt(b, a)
            result := slt(b, a) // 如果 b < a，则 a > b
        }
        return result;
    }
}