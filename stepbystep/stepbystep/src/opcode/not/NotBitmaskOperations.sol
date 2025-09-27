// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract NotBitmaskOperations {
    // 权限标志
    uint256 constant CAN_READ = 1 << 0;
    uint256 constant CAN_WRITE = 1 << 1;
    uint256 constant CAN_DELETE = 1 << 2;
    uint256 constant CAN_ADMIN = 1 << 3;
    
    /**
     * @dev 清除特定位（将特定位设为0）
     * @param value 原始值
     * @param mask 要清除的位掩码（要清除的位设为1）
     * @return 清除位后的值
     */
    function clearBits(uint256 value, uint256 mask) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 方法：value AND (NOT mask)
            // 先对掩码取反，然后与原始值进行AND操作
            result := and(value, not(mask))
        }
        return result;
    }
    
    /**
     * @dev 从权限集中移除特定权限
     * @param permissions 原始权限集
     * @param permissionsToRemove 要移除的权限掩码
     * @return 更新后的权限集
     */
    function removePermissions(uint256 permissions, uint256 permissionsToRemove) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := and(permissions, not(permissionsToRemove))
        }
        return result;
    }
    
    /**
     * @dev 检查权限是否完全被禁用
     * @param permissions 权限集
     * @param checkPermissions 要检查的权限
     * @return 如果所有检查的权限都被禁用返回true
     */
    function arePermissionsDisabled(uint256 permissions, uint256 checkPermissions) public pure returns (bool) {
        bool result;
        assembly {
            // 检查权限集中是否没有任何checkPermissions中的权限
            let common := and(permissions, checkPermissions)
            result := iszero(common)
        }
        return result;
    }
    
    /**
     * @dev 创建排除特定位的掩码
     * @param excludedBits 要排除的位掩码
     * @return 排除指定位后的全1掩码
     */
    function createInverseMask(uint256 excludedBits) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := not(excludedBits)
        }
        return result;
    }

}