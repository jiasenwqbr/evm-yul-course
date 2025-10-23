// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract TLoadExample {
    // 定义一个瞬时存储的键，通常使用 keccak256 hash 来避免冲突
   // bytes32 private constant EXPENSIVE_VALUE_KEY = keccak256("myapp.expensive_value");
    uint256 private constant EXPENSIVE_VALUE_KEY = 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF;

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

/**
 1. TLOAD 是什么？
TLOAD 是 Ethereum Cancun 升级（Dencun 硬分叉，于 2024 年 3 月 13 日激活）中引入的一个新的 EVM 操作码。它是 EIP-1153 提案“瞬时存储”的核心部分。
操作码编号： 0x5c
Gas 成本： 非常低，目前是 100（与 TSTORE 相同），远低于 SLOAD。
功能： 从瞬时存储中读取数据。
栈输入： 1 个元素：key - 要读取的存储槽的 32 字节键。
栈输出： 1 个元素：value - 从该存储槽中读取到的 32 字节值。

2. 瞬时存储的核心概念
要理解 TLOAD，必须先理解它操作的“瞬时存储”是什么。
瞬时存储 是一个类似于内存的临时、廉价的键值存储空间。它的主要特点是：
事务内有效： 瞬时存储中的数据仅在单个外部交易的执行期间存在。一旦交易结束（无论成功还是回滚），数据就会被清除。
跨调用/委托调用持久： 与内存不同，瞬时存储在合约的内部调用（CALL, DELEGATECALL, STATICCALL）中是持久的。这意味着你可以在一个合约的多个函数调用间共享瞬时数据。
极其廉价： TLOAD 和 TSTORE 的 Gas 成本都是 100，这比从持久存储中读取 (SLOAD, 至少 2100 Gas) 要便宜得多。
不持久化到链上： 瞬时存储的数据永远不会被写入区块链状态。它只存在于执行交易的 EVM 实例中。因此，节点在验证区块后无需存储这些数据，大大减轻了状态膨胀的压力。

类比：
持久存储： 像硬盘，数据永久保存，但读写慢且昂贵。
内存： 像 RAM，速度快，但数据在每次外部调用边界就会被重置。
瞬时存储： 像一种“事务级共享内存”，在整个交易的生命周期内存在，且在不同合约调用间共享。

3. TLOAD 的使用场景
TLOAD / TSTORE 的典型用途是作为事务内的临时缓存。
计算中间结果缓存：
如果一个复杂的计算在同一个交易的多个内部调用中需要被多次使用，可以先将结果存入瞬时存储。后续的调用只需通过 TLOAD 即可廉价地获取，无需重新计算或使用昂贵的 SLOAD。
可重入锁：
在单个交易中，防止合约的特定函数被重入。由于瞬时存储在整个交易中共享，它可以作为一个非常廉价的重入锁。
交易内标识符传递：
在复杂的多合约交互中，可以将某个标识符（如一个随机数或阶段标志）存入瞬时存储，以便在交易流经的不同合约中廉价地传递和读取。
Gas 优化：
这是最核心的动机。将频繁访问但无需永久保存的数据从持久存储移至瞬时存储，可以大幅降低交易的 Gas 消耗。
 */