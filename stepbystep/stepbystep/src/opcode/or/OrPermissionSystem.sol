// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrPermissionSystem {
    // 定义权限标志
    uint256 constant CAN_READ = 1 << 0;    // 1 (0b0001)
    uint256 constant CAN_WRITE = 1 << 1;   // 2 (0b0010) 
    uint256 constant CAN_DELETE = 1 << 2;  // 4 (0b0100)
    uint256 constant CAN_ADMIN = 1 << 3;   // 8 (0b1000)
    
    // 预定义角色权限
    uint256 constant ROLE_USER = CAN_READ;
    uint256 constant ROLE_EDITOR = CAN_READ | CAN_WRITE;
    uint256 constant ROLE_ADMIN = CAN_READ | CAN_WRITE | CAN_DELETE | CAN_ADMIN;
    
    mapping(address => uint256) public permissions;

    /**
     * @dev 为用户添加权限（不移除现有权限）
     */
    function addPermissions(address user, uint256 newPermissions) public {
        uint256 currentPerms = permissions[user];
        assembly {
            // 使用 OR 合并权限（保留原有权限，添加新权限）
            let updatedPerms := or(currentPerms, newPermissions)
            
            // 计算用户在映射中的存储位置
            mstore(0x00, user)
            mstore(0x20, permissions.slot)
            let storageSlot := keccak256(0x00, 0x40)
            
            // 更新存储
            sstore(storageSlot, updatedPerms)
        }
    }
    
    
    /**
     * @dev 创建自定义角色权限组合
     */
    function combinePermissions(uint256[] memory permissionFlags) public pure returns (uint256) {
        uint256 combined;
        assembly {
            // 遍历权限数组，使用 OR 组合所有标志
            let length := mload(permissionFlags)
            let dataPtr := add(permissionFlags, 0x20)
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                let flag := mload(add(dataPtr, mul(i, 0x20)))
                combined := or(combined, flag)
            }
        }
        return combined;
    }
    
    /**
     * @dev 检查用户是否具有任意指定权限
     */
    function hasAnyPermission(address user, uint256 requiredPermissions) public view returns (bool) {
        uint256 userPerms = permissions[user];
        bool result;
        assembly {
            // 检查用户权限和所需权限是否有交集
            let commonFlags := and(userPerms, requiredPermissions)
            result := gt(commonFlags, 0) // 如果有任何共同标志，结果 > 0
        }
        return result;
    }

}