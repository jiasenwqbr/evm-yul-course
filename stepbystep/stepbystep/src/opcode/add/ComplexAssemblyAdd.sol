// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ComplexAssemblyAdd {
    function complexAdd(uint256 x,uint256 y,uint256 z) public pure returns(uint256) {
        assembly {
            let sum_xy := add(x,y)
            if lt(sum_xy,x){
                revert(0,0)
            }

            let final_sum := add(sum_xy,z)
            if lt(final_sum,sum_xy) {
                revert(0,0)
            }

            // 将结果返回
            mstore(0x00,final_sum)
            return(0x00,0x20)

        }
    }
}