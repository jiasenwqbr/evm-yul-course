// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AddModExample {
     // 使用 ADDMOD 操作码（安全）
    function safeAddMod(uint256 a, uint256 b, uint256 modulus) public pure returns (uint256) {
        assembly {
            // 使用 addmod 操作码
            let result := addmod(a, b, modulus)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

    // 常规加法后取模（可能溢出）
    function unsafeAddMod(uint256 a, uint256 b, uint256 modulus) public pure returns (uint256) {
        return (a + b) % modulus;
    }

    // Solidity 0.8+ 的安全版本（使用unchecked避免自动检查）
    function soliditySafeAddMod(uint256 a, uint256 b, uint256 modulus) public pure returns (uint256) {
        // 在 0.8+ 中，直接 (a + b) 会溢出回滚
        // 使用 unchecked 来模拟不安全行为进行对比
        unchecked {
            return (a + b) % modulus;
        }
    }


}