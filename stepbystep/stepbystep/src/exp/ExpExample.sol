// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ExpExample {
    function powerWithExp(uint256 base,uint256 exponent) public pure returns(uint256) {
        assembly{
            let result := exp(base, exponent)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

     // 使用 Solidity 的 ** 运算符（0.8.0+）
    function powerWithSolidity(uint256 base, uint256 exponent) public pure returns (uint256) {
        return base ** exponent;
    }

    // 比较两种方法的结果
    function compareMethods(uint256 base, uint256 exponent) public pure returns (uint256 expResult, uint256 solidityResult) {
        expResult = powerWithExp(base, exponent);
        solidityResult = powerWithSolidity(base, exponent);
    }



}