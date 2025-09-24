// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AssemblySub {
    function subWithAssembly(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := sub(a, b)
        }
    }

    // 带下溢检查的汇编减法
    function safeSub(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := sub(a, b)
            
            // 检查是否下溢：如果结果 > a，则发生下溢
            if gt(result, a) {
                revert(0, 0)
            }
        }
    }
    function subtractMultiple(uint256 a, uint256 b, uint256 c) public pure returns (uint256) {
        assembly{
            let firstSub := sub(a,b)
            // 检查第一次减法是否下溢
            if gt(firstSub, a) {
                revert(0, 0)
            }
            
            // 再减 c
            let finalResult := sub(firstSub, c)
            // 检查第二次减法是否下溢
            if gt(finalResult, firstSub) {
                revert(0, 0)
            }
            
            // 返回结果
            mstore(0x00, finalResult)
            return(0x00, 0x20)
        }
    }


}