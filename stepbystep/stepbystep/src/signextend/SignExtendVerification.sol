// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SignExtendVerification {
    // 手动实现符号扩展来验证 SIGNEXTEND 的行为
    function manualSignExtend(uint256 size, uint256 value) public pure returns (int256) {
        // size 参数表示：扩展 (size + 1) 个字节
        uint256 byteSize = size + 1;
        require(byteSize <= 32, "Size too large");
        
        // 计算符号位的位置
        uint256 signBitPosition = byteSize * 8 - 1;
        uint256 signBit = (value >> signBitPosition) & 1;
        
        if (signBit == 0) {
            // 正数：高位补零
            uint256 mask = (1 << (byteSize * 8)) - 1;
            return int256(value & mask);
        } else {
            // 负数：高位补一
            uint256 mask = (1 << (byteSize * 8)) - 1;
            uint256 extended = value | (~mask);
            return int256(extended);
        }
    }
    
    // 比较手动实现和 SIGNEXTEND 的结果
    function compareMethods(uint256 size, uint256 value) public pure returns (int256 manual, int256 opcode) {
        manual = manualSignExtend(size, value);
        
        assembly {
            opcode := signextend(size, value)
        }
    }
}