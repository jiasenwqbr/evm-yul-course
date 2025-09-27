// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AddressValidator {
     address public owner;
    
    constructor(address _owner) {
        // 使用汇编验证传入的地址不是零地址
        assembly {
            // 如果 _owner == 0，则回滚
            if iszero(_owner) {
                revert(0, 0)
            }
        }
        owner = _owner;
    }
    
    /**
     * @dev 只有非零地址才能调用此函数
     */
    function importantFunction() public view {
        address user;
        assembly {
            user := caller()
        }
        
        assembly {
            // 检查调用者不是零地址
            if iszero(user) {
                revert(0, 0)
            }
        }
        
        // 函数继续执行...
    }
    
    // Solidity 等价写法
    function solidityStyleCheck(address _addr) public pure returns (bool) {
        require(_addr != address(0), "Zero address not allowed");
        return true;
    }
    
    // 汇编等价写法
    function assemblyStyleCheck(address _addr) public pure returns (bool) {
        bool isValid;
        assembly {
            isValid := iszero(iszero(_addr)) // 双重否定：非零地址返回 true
            // 或者更直接的方式：
            // if iszero(_addr) { revert(0, 0) }
            // isValid := 1
        }
        return isValid;
    }
}