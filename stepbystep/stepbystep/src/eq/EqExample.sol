// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EqExample {
    function isEqual(uint256 a,uint256 b) public pure returns(bool result){
        assembly{
            result := eq(a,b)
        }
    }
}