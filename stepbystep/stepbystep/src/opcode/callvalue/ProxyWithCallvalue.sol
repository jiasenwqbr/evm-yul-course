// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProxyWithCallvalue {

    address public implementation;
    event ValueForwarded(address indexed from, uint256 amount, address to);
    
    constructor(address _implementation) {
        implementation = _implementation;
    }
    
    fallback() external payable {
        address impl = implementation;
        
        uint256 callValue;
        assembly {
            callValue := callvalue()
        }
        
        require(impl != address(0), "Implementation not set");
        emit ValueForwarded(msg.sender, callValue, impl);
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            
            let result := delegatecall(
                gas(),
                impl,
                ptr,
                calldatasize(),
                0,
                0
            )
            
            returndatacopy(ptr, 0, returndatasize())
            
            switch result
            case 0 { revert(ptr, returndatasize()) }
            default { return(ptr, returndatasize()) }
        }
    }
    
    // 获取当前调用的值信息
    function getCallValueInfo() public view returns (uint256, uint256, bool) {
        uint256 currentValue;
        uint256 contractBalance;
        bool hasValue;
        
        assembly {
            currentValue := callvalue()
            contractBalance := selfbalance()
        }
        
        hasValue = (currentValue > 0);
        
        return (currentValue, contractBalance, hasValue);
    }

    // receive 专门用于接收 ETH
    receive() external payable {
        // 这里写接收到 ETH 的逻辑，比如事件
    }

}

// 实现合约
contract ImplementationWithValue {
    uint256 public totalValueReceived;
    mapping(address => uint256) public userContributions;
    
    event ValueReceived(address indexed from, uint256 amount, uint256 newTotal);
    
    function processPayment() public payable {
        uint256 receivedValue;
        assembly {
            receivedValue := callvalue()
        }
        
        totalValueReceived += receivedValue;
        userContributions[msg.sender] += receivedValue;
        
        emit ValueReceived(msg.sender, receivedValue, totalValueReceived);
    }
    
    function processPaymentWithData(bytes calldata data) public payable {
        uint256 receivedValue;
        assembly {
            receivedValue := callvalue()
        }
        
        // 处理数据和支付
        require(receivedValue > 0, "Payment required");
        require(data.length > 0, "Data required");
        
        totalValueReceived += receivedValue;
        userContributions[msg.sender] += receivedValue;
        
        emit ValueReceived(msg.sender, receivedValue, totalValueReceived);
    }
    
    // 在委托调用中检查 CALLVALUE
    function checkValueInDelegateCall() public view returns (
        uint256 callValue,
        address callerAddress,
        address contractAddress
    ) {
        assembly {
            callValue := callvalue()
            callerAddress := caller()
            contractAddress := address()
        }
        
        return (callValue, callerAddress, contractAddress);
    }
}