// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CodeSizeExample {
    // 使用内联汇编获取当前合约的代码大小
    function getMyCodeSize() public pure returns (uint256 size) {
        assembly {
            // 将 CODESIZE 的结果赋值给返回值 size
            size := codesize()
        }
    }

    // 一个普通函数，用于增加合约的总体大小
    function dummyFunction() public pure returns (string memory) {
        return "This is a dummy function to increase the contract's code size.";
    }
}

/**
 * 部署和测试：

将上述合约部署到 Remix IDE。

调用 getMyCodeSize 函数。

它会返回一个数字，例如 0x02f（十进制 751）或其他值。这个值就是整个 CodeSizeExample 合约编译后的运行时字节码的大小。

你可以尝试注释或取消注释 dummyFunction，然后重新编译部署，会发现 getMyCodeSize 的返回值发生了变化。
 * 
 * 
 */