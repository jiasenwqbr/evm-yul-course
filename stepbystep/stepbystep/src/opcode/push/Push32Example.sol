
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Push32Example {
    function push32FullHash() public pure returns (bytes32) {
        bytes32 result;
        assembly {
            // PUSH32 用于完整的哈希值
            let fullHash := 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF
            result := fullHash
        }
        return result;
    }
    
    function push32LargeNumbers() public pure returns (uint256) {
        uint256 result;
        assembly {
            // PUSH32 可以表示完整的 uint256
            let maxUint256 := 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            let largeNumber := 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF
            
            result := largeNumber
        }
        return result;
    }
    
    function push32BitOperations() public pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用 PUSH32 进行位操作
            let allOnes := 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            let mask := 0x00000000000000000000000000000000000000000000000000000000FFFFFFFF
            
            // 应用掩码
            result := and(allOnes, mask)  // 结果: 0xFFFFFFFF
        }
        return result;
    }
    
    function push32MemoryOperations() public pure {
        assembly {
            // 使用 PUSH32 设置内存值
            let value := 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF
            mstore(0x00, value)
            
            // 验证存储的值
            let loaded := mload(0x00)
            // loaded 应该等于 value
        }
    }
}

/**
重要注意事项
Gas 优化：总是使用能容纳数据的最小 PUSH 操作码

PUSH0 优势：在需要 0 值时优先使用 PUSH0 而不是 PUSH1 0x00

数据对齐：注意字节顺序和位偏移

编译器优化：Solidity 编译器会自动选择最优的 PUSH 操作码

栈限制：EVM 栈深度限制为 1024，合理使用 PUSH 操作

总结
PUSH 系列操作码是 EVM 编程的基础：

PUSH0：专门的零值操作，Gas 效率最高

PUSH1-PUSH8：用于小型数据和标志位

PUSH16-PUSH24：用于地址和中等数据

PUSH32：用于完整哈希值和大整数

合理选择 PUSH 操作码可以显著优化合约的 Gas 消耗和执行效率。
 */