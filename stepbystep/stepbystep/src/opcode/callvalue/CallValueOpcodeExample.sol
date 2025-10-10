// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallValueOpcodeExample {
     // 使用内联汇编获取调用值
    function getCallValueAssembly() public view returns (uint256) {
        uint256 value;
        assembly {
            value := callvalue()
        }
        return value;
    }

    // 比较 CALLVALUE 和 msg.value
    function compareCallValue() public  payable returns (uint256, uint256, bool) {
        uint256 assemblyValue;
        assembly {
            assemblyValue := callvalue()
        }
        
        uint256 solidityValue = msg.value;
        
        return (assemblyValue, solidityValue, assemblyValue == solidityValue);
    }
    
    // 检查是否有以太币发送
    function checkPayment() public view returns (bool, uint256) {
        uint256 valueSent;
        assembly {
            valueSent := callvalue()
        }
        
        bool hasValue = (valueSent > 0);
        return (hasValue, valueSent);
    }
}