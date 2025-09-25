
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
contract AddModOverflowDemo{
    // 演示 ADDMOD 防止溢出的价值
    function demonstrateOverflowProtection() public pure returns (uint256 safeResult, uint256 unsafeResult) {
        uint256 a = type(uint256).max;        // 2^256 - 1 (最大值)
        uint256 b = 100;                      // 任意加数
        uint256 modulus = 1000;               // 模数
        
        // 安全版本：使用 ADDMOD
        safeResult = safeAddMod(a, b, modulus);
        
        // 不安全版本：会溢出
        unsafeResult = unsafeAddMod(a, b, modulus);
    }
    
    function safeAddMod(uint256 a, uint256 b, uint256 modulus) internal pure returns (uint256) {
        assembly {
            let result := addmod(a, b, modulus)
            mstore(0x00, result)
            return(0x00, 32)
        }
    }
    
    function unsafeAddMod(uint256 a, uint256 b, uint256 modulus) internal pure returns (uint256) {
        unchecked {
            return (a + b) % modulus;
        }
    }
}