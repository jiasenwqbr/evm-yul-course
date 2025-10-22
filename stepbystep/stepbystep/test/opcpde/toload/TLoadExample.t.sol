// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; // 必须使用支持 EIP-1153 的编译器（0.8.24+）

import "forge-std/Test.sol";
import "../../../src/opcode/tload/TLoadExample.sol";

contract TLoadExampleTest is Test {
     TLoadExample example;

    function setUp() public {
        example = new TLoadExample();
    }

    /// @notice 测试 expensiveComputation 是否可重复确定
    function testExpensiveComputation() public view {
        uint256 input = 123;
        uint256 result1 = example.expensiveComputation(input);
        uint256 result2 = example.expensiveComputation(input);
        assertEq(result1, result2, "expensiveComputation should be deterministic");
    }

    /// @notice 测试 computeAndStore + getCachedValue 能正确使用瞬时存储
    function testComputeAndStoreAndLoad() public {
        uint256 input = 42;
        uint256 expected = example.expensiveComputation(input);

        example.computeAndStore(input);

        uint256 cached = example.getCachedValue();

        assertEq(cached, expected, "TLOAD should retrieve the value stored via TSTORE");
    }

    /// @notice 测试 getValueOptimized 首次计算时应执行计算逻辑
    function testGetValueOptimizedFirstCallComputes() public {
        uint256 input = 777;

        // 第一次调用应触发计算
        uint256 value1 = example.getValueOptimized(input);

        uint256 expected = example.expensiveComputation(input);
        assertEq(value1, expected, "First call should compute and cache the value");

        // 再次调用，应直接返回缓存，不再重新计算
        uint256 value2 = example.getValueOptimized(input);
        assertEq(value2, expected, "Second call should use cached value");
    }

    /// @notice 验证瞬时存储不会跨交易持久化
    function testTransientStorageClearedBetweenTransactions() public {
        uint256 input = 1234;

        // 交易1：设置缓存
        example.computeAndStore(input);
        uint256 value1 = example.getCachedValue();
        assertGt(value1, 0, "Transient storage should contain value in this tx");

        // 模拟新交易（在 Foundry 中，直接重新调用即可）
        uint256 value2 = example.getCachedValue();
        assertEq(value2, 0, "Transient storage should be cleared between transactions");
    }


}
