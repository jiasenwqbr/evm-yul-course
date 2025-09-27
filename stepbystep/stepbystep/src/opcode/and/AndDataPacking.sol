// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AndDataPacking {
    /**
     * @dev 从打包数据中提取多个字段
     * 假设数据格式：| 未使用 (160位) | 时间戳 (32位) | 类型 (8位) | 状态 (8位) | 值 (48位) |
     */
    function unpackData(uint256 packedData) public pure returns (
        uint256 ts,
        uint256 dataType, 
        uint256 status,
        uint256 value
    ) {
        assembly {
            // 提取值（最低48位）
            value := and(packedData, 0xFFFFFFFFFFFF) // 48位掩码
            
            // 提取状态（接下来的8位）
            status := and(shr(48, packedData), 0xFF) // 右移48位后取低8位
            
            // 提取类型（接下来的8位）
            dataType := and(shr(56, packedData), 0xFF) // 右移56位后取低8位
            
            // 提取时间戳（接下来的32位）
            ts := and(shr(64, packedData), 0xFFFFFFFF) // 右移64位后取低32位
        }
    }
    
    /**
     * @dev 将字段打包到一个256位字中
     */
    function packData(
        uint256 ts,
        uint256 dataType,
        uint256 status, 
        uint256 value
    ) public pure returns (uint256 packedData) {
        assembly {
            // 确保输入值在有效范围内
            if or(or(
                gt(ts, 0xFFFFFFFF),    // 时间戳超过32位
                gt(dataType, 0xFF)            // 类型超过8位
            ), or(
                gt(status, 0xFF),             // 状态超过8位  
                gt(value, 0xFFFFFFFFFFFF)     // 值超过48位
            )) {
                revert(0, 0)
            }
            
            // 打包数据
            packedData := value                    // 值占据最低48位
            packedData := or(packedData, shl(48, status))   // 状态占据位 48-55
            packedData := or(packedData, shl(56, dataType)) // 类型占据位 56-63
            packedData := or(packedData, shl(64, ts)) // 时间戳占据位 64-95
        }
    }
}