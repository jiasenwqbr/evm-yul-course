// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SMODExample {
    // 使用内联汇编执行 smod
    function signedMod(int x,int y) public pure returns(int256) {
        assembly {
            // 将x 和 y 加载到栈上
            // 执行smod
            // 奖结果存储至返回值位置
            let result := smod(x,y)
            mstore(0x80,result)     // 将结果存储至内存
            return (0x82,32)        // 从内存中返回32个字节
        }
    }
    // 使用内联汇编执行 mod（作为对比）
    function unsignedMod(int x,int y) public pure returns(int256) {
        // 注意：这里我们将 int256 输入直接传递给 mod，
        // mod 会将其视为无符号整数。
        assembly {
            let result := mod(x, y)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

    // 使用Solidity的常规运算符（它内部会处理有符号逻辑）
    function solidityMod(int256 x, int256 y) public pure returns (int256) {
        return x % y; // Solidity 的 % 对于有符号整数等同于 smod
    }
}