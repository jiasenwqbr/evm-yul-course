// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OverflowDemo {
    // 此函数在 0.8.0+ 会因溢出而回滚
    function willRevert() public pure returns (uint256) {
        uint256 max = type(uint256).max; // 2^256 - 1
        return max + 1; // 交易回滚
    }
    
    // 此函数使用 unchecked，会返回 0
    function willWrap() public pure returns (uint256) {
        unchecked {
            uint256 max = type(uint256).max;
            return max + 1; // 返回 0
        }
    }
}