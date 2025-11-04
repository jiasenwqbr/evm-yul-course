// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 简单的代理合约
contract Proxy {
    // 逻辑合约地址存储在指定的存储槽中，防止冲突
    bytes32 private constant IMPLEMENTATION_SLOT = 
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    
    // Admin地址存储槽
    bytes32 private constant ADMIN_SLOT = 
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);
    
    event Upgraded(address indexed implementation);
    event AdminChanged(address previousAdmin, address newAdmin);
    
    constructor(address _logic, address _admin, bytes memory _data) {
        _setImplementation(_logic);
        _setAdmin(_admin);
        
        // 如果有初始化数据，就调用逻辑合约
        if (_data.length > 0) {
            (bool success, ) = _logic.delegatecall(_data);
            require(success, "Initialization failed");
        }
    }
    
    // 回退函数 - 核心机制
    fallback() external payable {
        address implementation = _getImplementation();
        require(implementation != address(0), "Implementation not set");
        
        // 使用delegatecall执行逻辑合约的代码
        assembly {
            // 复制calldata到内存
            calldatacopy(0, 0, calldatasize())
            
            // 使用delegatecall调用逻辑合约
            let result := delegatecall(
                gas(),
                implementation,
                0,
                calldatasize(),
                0,
                0
            )
            
            // 复制返回数据
            returndatacopy(0, 0, returndatasize())
            
            // 处理返回结果
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
    
    receive() external payable {}
    
    // 升级函数 - 只能由admin调用
    function upgradeTo(address newImplementation) external {
        require(msg.sender == _getAdmin(), "Only admin");
        _setImplementation(newImplementation);
    }
    
    function changeAdmin(address newAdmin) external {
        require(msg.sender == _getAdmin(), "Only admin");
        require(newAdmin != address(0), "Invalid admin");
        _setAdmin(newAdmin);
    }
    
    function getImplementation() external view returns (address) {
        return _getImplementation();
    }
    
    function getAdmin() external view returns (address) {
        return _getAdmin();
    }
    
    // 内部函数
    function _getImplementation() internal view returns (address impl) {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            impl := sload(slot)
        }
    }
    
    function _setImplementation(address newImplementation) internal {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            sstore(slot, newImplementation)
        }
        emit Upgraded(newImplementation);
    }
    
    function _getAdmin() internal view returns (address admin) {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            admin := sload(slot)
        }
    }
    
    function _setAdmin(address newAdmin) internal {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            sstore(slot, newAdmin)
        }
        emit AdminChanged(_getAdmin(), newAdmin);
    }
}