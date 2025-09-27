// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AssesmblyAdd {
    function addWithAssembly(uint256 a,uint256 b) public pure returns(uint256 result) {
        assembly {
            result := add(a,b)
        }
    }

    function addWithAssemblyOverFlowCheck(uint256 a,uint256 b) public pure returns(uint256 result) {
        assembly{
            result := add(a,b)
            if  and(lt(0,a) , lt(0,b)){
                if lt(result,a){
                    revert(0,0)
                }
            }
        }
    }
}