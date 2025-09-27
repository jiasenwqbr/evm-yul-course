// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SignExtendBasic {
    // 使用 SIGNEXTEND 操作码
    function signExtend(uint256 size,uint256 value) public pure returns (int256 extended){
        assembly {
            let result := signextend(size,value)
            mstore(0x80, result)
            return(0x80, 32)
        }
    }

    // 演示不同大小的符号扩展
    function demonstrateSignExtend() public pure returns (int256[] memory results) {
        results = new int256[](6);
        
        // 扩展 1 字节有符号数
        results[0] = signExtend(0, 0x7F);   // 127 → 127
        results[1] = signExtend(0, 0x80);   // -128 → -128
        results[2] = signExtend(0, 0xFF);   // -1 → -1
        
        // 扩展 2 字节有符号数
        results[3] = signExtend(1, 0x7FFF);   // 32767 → 32767
        results[4] = signExtend(1, 0x8000);   // -32768 → -32768
        results[5] = signExtend(1, 0xFFFF);   // -1 → -1
    }

}