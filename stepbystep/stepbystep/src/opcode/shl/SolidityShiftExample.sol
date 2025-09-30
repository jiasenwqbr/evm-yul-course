// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityShiftExample {
    // 这个函数与内联汇编的 shiftLeft 函数行为完全一致
    function solidityShiftLeft(uint256 value, uint256 shift) public pure returns (uint256) {
        return value << shift;
    }

    // 同样，计算 2 的 n 次方
    function solidityPowerOfTwo(uint256 exponent) public pure returns (uint256) {
        // Solidity 0.8+ 会自动检查移位溢出
        // 如果 exponent >= 256，此操作会自动回滚交易
        return 1 << exponent;
    }
}