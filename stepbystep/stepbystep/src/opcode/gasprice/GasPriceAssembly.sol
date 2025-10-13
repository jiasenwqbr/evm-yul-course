// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GasPriceAssembly {
    // 使用内联汇编获取 gasPrice
    function getGasPriceWithAssembly() public view returns (uint256 gasPrice) {
        assembly {
            // 使用 gasprice 操作码，将结果压入栈顶
            // 然后通过 := 赋值给返回变量 gasPrice
            gasPrice := gasprice()
        }
    }

    // 对比Solidity高级语法
    function getGasPriceSolidity() public view returns (uint256) {
        return tx.gasprice;
    }
}