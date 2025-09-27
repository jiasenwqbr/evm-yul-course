// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyMod{
    // 使用内联汇编取模
    function modWithAssembly(uint256 a,uint256 b) public pure returns(uint256 result){
        assembly {
            result := mod(a,b)
        }
    }

    function safeModAssembly(uint256 a,uint256 b) public pure returns(uint256 result){
        assembly{
            // 排查除零
            if iszero(b){
                revert(0,0)
            }
            result := mod(a,b)
        }
    }
    // 同时获取商和余数
    function divMod(uint256 a,uint256 b) public pure returns (uint256 quotient,uint256 remainder) {
        assembly{
            if iszero(b) {
                revert(0,0)
            }
            quotient := div(a,b)
            remainder := mod(a,b)
        }
    }

    // 检查是否能整除
    function isDivisible(uint256 a,uint256 b) public pure returns(bool) {
        assembly {
            let r := 0
            if iszero(b) {
                mstore(0x00,0)
                return(0x00,0x20)
            }

            let rem := mod(a,b)
            if iszero(rem) {
               r := 1
            } 
             mstore(0x00,r)
            return (0x00,0x20)
        }
    }

}