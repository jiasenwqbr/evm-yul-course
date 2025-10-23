// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PcBasic {
    function getProgramCounter() public pure returns (uint256 position) {
        assembly {
            // 获取当前程序计数器位置
            // position := pc()
        }
    }
    
    function multiplePc() public pure returns (uint256 pos1, uint256 pos2, uint256 pos3) {
        assembly {
            // pos1 := pc()  // 第一个 PC 的位置
            // pop(pc())     // 第二个 PC 的位置（弹出不用）
            // pos2 := pc()  // 第三个 PC 的位置
            // mstore(0x00, pc()) // 第四个 PC 的位置
            // pos3 := mload(0x00)
        }
    }
    
    function demonstratePcBehavior() public pure returns (uint256[5] memory positions) {
        assembly {
            // 记录多个位置的 PC 值
            // positions[0] := pc()
            // positions[1] := pc()
            // positions[2] := pc()
            // positions[3] := pc()
            // positions[4] := pc()
            
            // 所有这些值可能是相同的，因为PC返回的是自身位置
            // 实际值取决于编译器生成的字节码布局
        }
    }
}
