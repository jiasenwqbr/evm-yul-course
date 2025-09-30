// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OriginOpcodeExample{
    // 使用内联汇编获取原始发送者
    function getOriginAssembly() public view returns (address) {
        address originAddr;
        assembly {
            originAddr := origin()
        }
        return originAddr;
    }

    // 比较 ORIGIN、CALLER 和 ADDRESS
    function compareContexts() public view returns (
        address originAddr,
        address callerAddr, 
        address contractAddr,
        bool isOriginCallerSame,
        bool isOriginContract
    ) {
        assembly {
            originAddr := origin()
            callerAddr := caller()
            contractAddr := address()
        }
        
        isOriginCallerSame = (originAddr == callerAddr);
        isOriginContract = (originAddr == contractAddr);
        
        return (originAddr, callerAddr, contractAddr, isOriginCallerSame, isOriginContract);
    }

    // 在复杂调用链中跟踪原始发送者
    function getCallChainInfo() public view returns (
        address txOrigin,
        address immediateCaller,
        address currentContract,
        uint256 callDepth
    ) {
        assembly {
            txOrigin := origin()
            immediateCaller := caller()
            currentContract := address()
        }
        
        // 简单模拟调用深度（实际中需要更复杂的跟踪）
        callDepth = 0;
        if (txOrigin != immediateCaller) {
            callDepth = 1;
        }
        
        return (txOrigin, immediateCaller, currentContract, callDepth);
    }



}