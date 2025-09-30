// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ByteDataPacking {
    /**
     * @dev 从打包数据中提取多个字段
     * 数据格式：| 时间戳 (4字节) | 类型 (1字节) | 状态 (1字节) | 值 (2字节) |
     */
    function unpackData(bytes32 packedData) public pure returns (
        uint32 ts,
        uint8 dataType,
        uint8 status,
        uint16 value
    ) {
        assembly {
            // 提取值（最低2字节）
            let byte30 := byte(30, packedData)  // 第30字节
            let byte31 := byte(31, packedData)  // 第31字节
            value := or(shl(8, byte30), byte31)
            
            // 提取状态（第29字节）
            status := byte(29, packedData)
            
            // 提取类型（第28字节）
            dataType := byte(28, packedData)
            
            // 提取时间戳（第24-27字节）
            ts := or(
                or(
                    shl(24, byte(24, packedData)),
                    shl(16, byte(25, packedData))
                ),
                or(
                    shl(8, byte(26, packedData)),
                    byte(27, packedData)
                )
            )
        }
    }
    
    /**
     * @dev 将字段打包到32字节中
     */
    function packData(
        uint32 ts,
        uint8 dataType,
        uint8 status,
        uint16 value
    ) public pure returns (bytes32) {
        bytes32 packed;
        assembly {
            // 打包值（最低2字节）
            packed := or(
                shl(240, and(value, 0xFFFF)),  // 值占据位 240-255
                or(
                    shl(232, and(status, 0xFF)),  // 状态占据位 232-239
                    or(
                        shl(224, and(dataType, 0xFF)),  // 类型占据位 224-231
                        shl(192, and(ts, 0xFFFFFFFF))  // 时间戳占据位 192-223
                    )
                )
            )
        }
        return packed;
    }
    
    /**
     * @dev 使用 byte 操作码验证数据格式
     */
    function validateDataFormat(bytes32 data) public pure returns (bool) {
        bool isValid;
        assembly {
            // 检查魔术字（前4字节）
            let magic := or(
                or(
                    shl(24, byte(0, data)),
                    shl(16, byte(1, data))
                ),
                or(
                    shl(8, byte(2, data)),
                    byte(3, data)
                )
            )
            
            // 检查版本号（第4字节）
            let version := byte(4, data)
            
            // 验证魔术字和版本号
            isValid := and(
                eq(magic, 0x12345678),  // 预期的魔术字
                eq(version, 0x01)       // 版本1
            )
        }
        return isValid;
    }
}