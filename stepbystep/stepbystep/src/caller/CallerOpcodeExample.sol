// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract CallerOpcodeExample {
    // 使用内联汇编获取调用者
    function getCallerAssembly() public view returns (address) {
        address callerAddr;
        assembly {
            callerAddr := caller()
        }
        return callerAddr;
    }

    // 比较 CALLER、ORIGIN 和 ADDRESS
    function compareContexts() public view returns (
        address callerAddr,
        address originAddr,
        address contractAddr,
        bool isCallerOrigin,
        bool isCallerContract
    ) {
        assembly {
            callerAddr := caller()
            originAddr := origin()
            contractAddr := address()
        }
        
        isCallerOrigin = (callerAddr == originAddr);
        isCallerContract = (callerAddr == contractAddr);
        
        return (callerAddr, originAddr, contractAddr, isCallerOrigin, isCallerContract);
    }
    
    // 在复杂调用链中跟踪调用者
    function getNestedCallInfo() public payable  returns (
        address immediateCaller,
        address currentContract,
        uint256 valueSent
    ) {
        assembly {
            immediateCaller := caller()
            currentContract := address()
        }
        
        // 获取调用时发送的以太币数量
        valueSent = msg.value;
        
        return (immediateCaller, currentContract, valueSent);
    }


}