// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract SltSignedMath {
    /**
     * @dev 返回两个有符号整数中较小的一个。
     * @param x 第一个有符号整数
     * @param y 第二个有符号整数
     * @return min 较小的那个数
     */
    function min(int256 x, int256 y) public pure returns (int256 min) {
        assembly {
            // 使用 slt 比较 x 和 y
            // 如果 y < x (即 slt(x, y) 为真)，则 min = y
            // 否则 min = x
            min := y
            if iszero(slt(x, y)) {
                min := x
            }

            // 另一种等价写法，使用条件跳转：
            // if slt(x, y) {
            //     min := y
            // }
            // if iszero(slt(x, y)) {
            //     min := x
            // }
        }
    }
}

/**
 * 测试上述函数:

min(5, 10) -> 10 < 5？ 否 -> 返回 5

min(10, 5) -> 5 < 10？ 是 -> 返回 5

min(-10, 5) -> 5 < -10？ 否 -> 返回 -10

min(10, -5) -> -5 < 10？ 是 -> 返回 -5
 */