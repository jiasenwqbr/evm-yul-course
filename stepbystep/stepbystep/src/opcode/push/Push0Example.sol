// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PushExample {
    // 使用push0的各种场景
    function usePush0ForInitialization() public pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用 PUSH0 初始化变量
            let x := 0  // 编译器可能会优化为 PUSH0
            result := x

        }
        return result;
    }

    function usePush0InLoop() public pure returns (uint256) {
        uint256 sum;
        assembly {
            // 循环初始化
            let i := 0  // PUSH0
            let end := 5
            
            // 循环累加
            for {} lt(i, end) { i := add(i, 1) } {
                sum := add(sum, i)
            }
        }
        return sum; // 返回 0+1+2+3+4 = 10
    }

    function usePush0ForMemory() public pure returns (uint256) {
        assembly {
            // 使用 PUSH0 清零内存
            let ptr := mload(0x40) // 获取自由内存指针
            mstore(ptr, 0)         // 使用 PUSH0 优化的清零
            return(ptr, 0x20)
        }
    }
}