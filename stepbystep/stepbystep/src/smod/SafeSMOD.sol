// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SafeSMOD {
    /**
     * 一个安全的的有符号取模函数。
     * 如果除数为0，则回滚交易。
     */

    function  safeSignedMod(int256 x, int256 y) public pure returns (int256) {
        // 在汇编外进行安全检查更清晰
        require(y != 0, "Division by zero");

        assembly{
            let result := smod(x, y)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

    /**
     * 另一种在汇编内进行检查的方式。
     */
    function safeSignedMod2(int256 x, int256 y) public pure returns (int256 result) {
        assembly {
            // 如果 y 为 0，跳转到错误处理标签
            if iszero(y) {
                // 触发错误，还原状态
                revert(0, 0)
            }
            result := smod(x, y)
        }
    }
}