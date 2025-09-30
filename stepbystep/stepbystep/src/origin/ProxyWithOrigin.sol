// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProxyWithOrigin {
    address public implementation;
    address public admin;
    
    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }
    
    fallback() external payable {
        address impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            
            let result := delegatecall(
                gas(),
                impl,
                0,
                calldatasize(),
                0,
                0
            )
            
            returndatacopy(0, 0, returndatasize())
            
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    
    // 获取代理合约上下文中的原始发送者
    function getProxyOrigin() public view returns (address) {
        address originAddr;
        assembly {
            originAddr := origin()
        }
        return originAddr;
    }
    
    // 升级实现合约（仅允许原始部署者）
    function upgradeImplementation(address newImplementation) public {
        address currentOrigin;
        assembly {
            currentOrigin := origin()
        }
        
        require(currentOrigin == admin, "Only original deployer can upgrade");
        implementation = newImplementation;
    }

    // receive 专门用于接收 ETH
    receive() external payable {
        // 这里写接收到 ETH 的逻辑，比如事件
    }
}


// 实现合约
contract ProxyWithOriginImplementation {
    function checkOriginInDelegateCall() public view returns (
        address originInImpl,
        address callerInImpl,
        address thisInImpl
    ) {
        assembly {
            originInImpl := origin()
            callerInImpl := caller()
            thisInImpl := address()
        }
        
        return (originInImpl, callerInImpl, thisInImpl);
    }
}