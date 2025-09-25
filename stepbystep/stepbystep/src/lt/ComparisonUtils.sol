// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library ComparisonUtils {
    // 检查 a < b
    function isLessThan(uint256 a, uint256 b) internal pure returns (bool) {
        bool result;
        assembly {
            result := lt(a, b)
        }
        return result;
    }
    
    // 检查 a <= b
    function isLessThanOrEqual(uint256 a, uint256 b) internal pure returns (bool) {
        bool result;
        assembly {
            // a <= b 等价于 !(b < a)
            result := iszero(lt(b, a))
        }
        return result;
    }
    
    // 检查 a > b
    function isGreaterThan(uint256 a, uint256 b) internal pure returns (bool) {
        bool result;
        assembly {
            // a > b 等价于 b < a
            result := lt(b, a)
        }
        return result;
    }
    
    // 检查 a >= b
    function isGreaterThanOrEqual(uint256 a, uint256 b) internal pure returns (bool) {
        bool result;
        assembly {
            // a >= b 等价于 !(a < b)
            result := iszero(lt(a, b))
        }
        return result;
    }
    
    // 三值比较：返回 -1(a<b), 0(a==b), 1(a>b)
    function compare(uint256 a, uint256 b) internal pure returns (int256) {
        int256 result;
        assembly {
            switch lt(a, b)
            case 1 {
                result := sub(0, 1)
                // result := not(0)   // 等于 -1
            }
            default {
                switch lt(b, a)
                case 1 {
                    result := 1
                }
                default {
                    result := 0
                }
            }
        }
        return result;
    }
    
    // 查找数组中的最小值
    function findMin(uint256[] memory array) internal pure returns (uint256 minValue, uint256 minIndex) {
        require(array.length > 0, "Empty array");
        
        minValue = type(uint256).max;
        minIndex = 0;
        
        assembly {
            let length := mload(array)
            let dataPtr := add(array, 0x20)
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let value := mload(add(dataPtr, mul(i, 0x20)))
                
                if lt(value, minValue) {
                    minValue := value
                    minIndex := i
                }
            }
        }
    }
    
    // 检查数组是否已排序（升序）
    function isSorted(uint256[] memory array) internal pure returns (bool) {
        if (array.length <= 1) return true;
        
        bool sorted;
        assembly {
            let length := mload(array)
            let dataPtr := add(array, 0x20)
            sorted := 1
            
            for { let i := 1 } lt(i, length) { i := add(i, 1) } {
                let prev := mload(add(dataPtr, mul(sub(i, 1), 0x20)))
                let curr := mload(add(dataPtr, mul(i, 0x20)))
                
                // 如果前一个元素 > 当前元素，则未排序
                if lt(curr, prev) {
                    sorted := 0
                    break
                }
            }
        }
        return sorted;
    }
}

contract ComparisonDemo {
    using ComparisonUtils for uint256[];
    
    function demoLibraryFunctions() public pure returns (bool[6] memory results) {
        results[0] = ComparisonUtils.isLessThan(5, 10);           // true
        results[1] = ComparisonUtils.isLessThanOrEqual(5, 5);     // true
        results[2] = ComparisonUtils.isGreaterThan(10, 5);        // true
        results[3] = ComparisonUtils.isGreaterThanOrEqual(5, 5);  // true
        
        int256 cmpResult1 = ComparisonUtils.compare(5, 10);       // -1
        int256 cmpResult2 = ComparisonUtils.compare(10, 5);       // 1
        int256 cmpResult3 = ComparisonUtils.compare(5, 5);        // 0
        
        results[4] = (cmpResult1 == -1);
        results[5] = (cmpResult2 == 1) && (cmpResult3 == 0);
    }
    
    function findArrayMin() public pure returns (uint256 minValue) {
        uint256[] memory data = new uint256[](5);
        data[0] = 45;
        data[1] = 12;
        data[2] = 78;
        data[3] = 3;
        data[4] = 56;
        
        (minValue, ) = ComparisonUtils.findMin(data);
        // minValue = 3
    }
}