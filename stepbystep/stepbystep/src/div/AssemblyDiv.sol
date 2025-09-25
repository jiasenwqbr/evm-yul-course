// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyDiv {
    function divWithAssembly(uint256 a,uint256 b) public pure returns(uint256 result) {
        assembly{
            result := div(a,b)
        }
    }

    function safeDivAssembly(uint256 a,uint256 b) public pure returns(uint256 result) {
        assembly {
            if iszero(b) {
                revert(0,0)
            }
            result := div(a,b)
        }
    }

    // 计算带余数的除法
    function divWithRemainder(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 quotient, uint256 remainder) {
        assembly {
            // 检查除零
            if iszero(b) {
                revert(0, 0)
            }
            
            quotient := div(a, b)
            remainder := mod(a, b)
        }
    }


}