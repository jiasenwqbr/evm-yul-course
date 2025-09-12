// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AssemblyCalldata {
    // 通过 ABI 调用： func(a:uint256, b:uint256)
    function addFromCalldata(uint256 a, uint256 b) external pure returns (uint256 sum){
        assembly {
            // calldata 布局：0..3 selector, 4..35 第一参数, 36..67 第二参数
            let calldataA := calldataload(4)
            let calldataB := calldataload(36)
            sum := add(calldataA,calldataB)
        }
    }
}