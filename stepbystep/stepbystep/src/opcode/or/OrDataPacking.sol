// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrDataPacking {
    /**
     * @dev 将多个字段打包到一个256位字中
     * 数据格式：| 未使用 (160位) | 时间戳 (32位) | 类型 (8位) | 状态 (8位) | 值 (48位) |
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
            
            // 使用 OR 组合所有字段
            packedData := value                    // 值占据最低48位
            packedData := or(packedData, shl(48, status))   // 状态占据位 48-55
            packedData := or(packedData, shl(56, dataType)) // 类型占据位 56-63
            packedData := or(packedData, shl(64, ts)) // 时间戳占据位 64-95
        }
    }
    
    /**
     * @dev 创建位掩码用于设置特定位范围
     */
    function createBitmask(uint256 bitLength, uint256 bitOffset) public pure returns (uint256) {
        uint256 mask;
        assembly {
            // 创建指定长度的位掩码： (1 << bitLength) - 1
            let baseMask := sub(shl(bitLength, 1), 1)
            // 将掩码移动到指定偏移位置
            mask := shl(bitOffset, baseMask)
        }
        return mask;
    }
    
    /**
     * @dev 更新打包数据中的特定字段
     */
    function updateFieldInPackedData(
        uint256 packedData,
        uint256 newValue,
        uint256 bitLength,
        uint256 bitOffset
    ) public pure returns (uint256) {
        uint256 updatedData;
        assembly {
            // 1. 创建清除掩码：清除目标字段的位
            let clearMask := not(shl(bitOffset, sub(shl(bitLength, 1), 1)))
            let clearedData := and(packedData, clearMask)
            
            // 2. 确保新值在有效范围内
            if gt(newValue, sub(shl(bitLength, 1), 1)) {
                revert(0, 0)
            }
            
            // 3. 将新值移动到正确位置并与原数据合并
            let shiftedValue := shl(bitOffset, newValue)
            updatedData := or(clearedData, shiftedValue)
        }
        return updatedData;
    }









}