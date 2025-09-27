// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrExample {
    
    /**
     * @dev 对两个数进行按位或操作
     * @param a 第一个数
     * @param b 第二个数
     * @return result 按位或的结果
     */
    function bitwiseOr(uint256 a,uint256 b) public pure returns(uint256){
        uint256 result;
        assembly{
            result := or(a,b)
        }
        return result;
    }
}