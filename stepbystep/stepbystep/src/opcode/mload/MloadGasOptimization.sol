// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MloadGasOptimization {
    function efficientLoads(uint256[2] memory input) public pure returns(uint256) {
        assembly {
            let inputPtr := input
            // 一次性读取两个相邻的元素
            let first := mload(add(inputPtr, 0x20)) // input[0]
            let second := mload(add(inputPtr, 0x40)) // input[1]
            // 对它们进行操作
            let sum := add(first, second)
            mstore(0x00, sum)
            return(0x00, 0x20)
        }
    }
}