// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AndExample {

    function bitwiseAnd(uint256 a,uint256 b) public pure returns(uint256){
        uint256 result;
        assembly{
            result := and(a,b)
        }
        return result;
    }

}


/**
 * 

bitwiseAnd(0b1100, 0b1010) = 0b1100 & 0b1010 = 0b1000 (8)
bitwiseAnd(0xFF, 0xF0) = 0xFF & 0xF0 = 0xF0 (240)
bitwiseAnd(15, 7) = 15 & 7 = 7

 */