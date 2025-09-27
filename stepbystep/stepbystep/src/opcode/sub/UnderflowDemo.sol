// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract UnderflowDemo {
    // 此函数会因下溢而回滚
    function willRevert() public pure returns (uint256) {
        uint256 small = 5;
        uint256 large = 10;
        return small - large; // 交易回滚
    }
    
    // 此函数使用 unchecked，会返回下溢结果
    function willUnderflow() public pure returns (uint256) {
        unchecked {
            uint256 small = 5;
            uint256 large = 10;
            return small - large; // 返回 2^256 - 5
        }
    }
    
    // 演示边界情况：0 - 1
    function zeroMinusOne() public pure returns (uint256) {
        unchecked {
            uint256 a = 0;
            uint256 b = 1;
            return a - b; // 返回 2^256 - 1 (最大值)
        }
    }
}