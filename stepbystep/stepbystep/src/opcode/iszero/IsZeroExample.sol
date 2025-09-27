// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IsZeroExample {
    /**
     * @dev 检查一个值是否为零。
     * @param _value 要检查的值
     * @return 如果 _value == 0 返回 true，否则返回 false。
     */
    function checkIfZero(uint256 _value) public pure returns (bool) {
        bool result;
        assembly {
            result := iszero(_value) // 如果 _value == 0，result = 1 (true)
        }
        return result;
    }
}