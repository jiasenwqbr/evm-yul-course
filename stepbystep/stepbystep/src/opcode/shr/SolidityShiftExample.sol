// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityShiftExample {
    // 这个函数与内联汇编的 shiftRight 函数行为完全一致
    function solidityShiftRight(uint256 value, uint256 shift) public pure returns (uint256) {
        return value >> shift;
    }

    // 同样，快速除以 2 的 n 次方
    function solidityDivideByPowerOfTwo(uint256 value, uint256 exponent) public pure returns (uint256) {
        return value >> exponent;
    }
}

