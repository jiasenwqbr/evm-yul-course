// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GasOptimizedComparisons {
    // 批量比较（减少函数调用开销）
    function batchCompare(
        uint256[] memory a, 
        uint256[] memory b
    ) public pure returns (bool[] memory results) {
        require(a.length == b.length, "Arrays length mismatch");
        
        results = new bool[](a.length);
        
        assembly {
            let aPtr := add(a, 0x20)
            let bPtr := add(b, 0x20)
            let resultsPtr := add(results, 0x20)
            let length := mload(a)
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let aVal := mload(add(aPtr, mul(i, 0x20)))
                let bVal := mload(add(bPtr, mul(i, 0x20)))
                let result := lt(aVal, bVal)
                mstore(add(resultsPtr, mul(i, 0x20)), result)
            }
        }
    }
    
    // 内联汇编的条件逻辑
    function optimizedConditional(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        
        assembly {
            // 如果 a < b，返回 a*2，否则返回 b*3
            if lt(a, b) {
                result := mul(a, 2)
            }
            result := mul(b, 3)
        }
        
        return result;
    }
    
    // 使用 LT 进行范围检查（比两次比较更高效）
    function isInRange(uint256 value, uint256 min, uint256 max) public pure returns (bool) {
        bool result;
        
        assembly {
            // value >= min AND value < max
            result := and(
                iszero(lt(value, min)),  // value >= min
                lt(value, max)           // value < max
            )
        }
        
        return result;
    }
}