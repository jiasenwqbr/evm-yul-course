// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract TLoadExample {
    // 定义一个瞬时存储的键，通常使用 keccak256 hash 来避免冲突
    bytes32 private constant EXPENSIVE_VALUE_KEY = keccak256("myapp.expensive_value");

    // 一个模拟的昂贵计算函数
    function expensiveComputation(uint256 input) public pure returns (uint256) {
        // 模拟复杂计算，例如多次哈希或循环
        return uint256(keccak256(abi.encode(input)));
    }

    // 计算并存储结果到瞬时存储
    function computeAndStore(uint256 input) public {
        uint256 result = expensiveComputation(input);
        // 使用内联汇编进行 TSTORE
        assembly {
            // 将 result 存入 EXPENSIVE_VALUE_KEY 对应的槽
            tstore(EXPENSIVE_VALUE_KEY, result)
        }
    }

    // 从瞬时存储中读取之前计算的值
    function getCachedValue() public view returns (uint256) {
        uint256 cachedValue;
        // 使用内联汇编进行 TLOAD
        assembly {
            // 从 EXPENSIVE_VALUE_KEY 对应的槽加载值到 cachedValue
            cachedValue := tload(EXPENSIVE_VALUE_KEY)
        }
        return cachedValue;
    }

    // 一个组合函数，演示完整的“如果缓存存在则用，否则计算”的逻辑
    function getValueOptimized(uint256 input) public returns (uint256) {
        uint256 cachedValue;
        assembly {
            cachedValue := tload(EXPENSIVE_VALUE_KEY)
        }

        // 如果缓存的值是 0（或者一个你定义的“未设置”标记），则重新计算
        // 注意：如果你的计算结果可能就是0，这个逻辑需要调整。
        if (cachedValue == 0) {
            cachedValue = expensiveComputation(input);
            assembly {
                tstore(EXPENSIVE_VALUE_KEY, cachedValue)
            }
        }
        return cachedValue;
    }
}