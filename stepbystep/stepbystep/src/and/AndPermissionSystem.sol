// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AndPermissionSystem {
     // 定义权限标志
    uint256 constant CAN_READ = 1 << 0;    // 1 (0b0001)
    uint256 constant CAN_WRITE = 1 << 1;   // 2 (0b0010) 
    uint256 constant CAN_DELETE = 1 << 2;  // 4 (0b0100)
    uint256 constant CAN_ADMIN = 1 << 3;   // 8 (0b1000)
    
    // 存储用户的权限位图
    mapping(address => uint256) public permissions;
    
    function setPermissions(address user, uint256 newPermissions) public {
        permissions[user] = newPermissions;
    }
    
    /**
     * @dev 检查用户是否具有特定权限
     */
    function hasPermission(address user, uint256 permissionFlag) public view returns (bool) {
        bool result;
        uint256 userPerms = permissions[user];
        assembly {
            // 检查权限位是否被设置
            result := iszero(iszero(and(userPerms, permissionFlag)))
        }
        return result;
    }
    
    /**
     * @dev 添加权限（不覆盖现有权限）
     */
    function addPermission(address user, uint256 permissionFlag) public {
        uint256 currentPerms = permissions[user];
        assembly {
            // 使用 OR 操作添加权限位
            let newPerms := or(currentPerms, permissionFlag)
            // 更新存储
            // sstore(permissions.slot, 
            //     // 计算用户在映射中的存储位置...
            //     // 简化版，实际需要计算keccak256哈希
            // )
        }
    }
    
    /**
     * @dev 移除权限
     */
    function removePermission(address user, uint256 permissionFlag) public {
        uint256 currentPerms = permissions[user];
        assembly {
            // 使用 AND 与 NOT 来移除权限位
            let newPerms := and(currentPerms, not(permissionFlag))
            // 更新存储...
        }
    }
}