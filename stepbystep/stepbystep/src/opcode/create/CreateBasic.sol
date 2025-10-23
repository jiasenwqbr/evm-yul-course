// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 将被创建的简单合约
contract SimpleStorage {
    uint256 public data;
    
    constructor(uint256 _data) {
        data = _data;
    }
    
    function setData(uint256 _data) public {
        data = _data;
    }
}

contract CreateBasic {
    address public createdAddress;
    
    // 使用 Solidity 的 new 关键字
    function createWithNew(uint256 initialData) public returns (address) {
        SimpleStorage newContract = new SimpleStorage(initialData);
        createdAddress = address(newContract);
        return createdAddress;
    }
    
    // 使用 CREATE 操作码
    function createWithAssembly(uint256 initialData) public returns (address) {
        address newContract;
        
        // 获取 SimpleStorage 的字节码（带构造函数参数）
        bytes memory bytecode = type(SimpleStorage).creationCode;
        bytes memory creationCode = abi.encodePacked(bytecode, abi.encode(initialData));
        
        assembly {
            // 在内存中存储初始化代码
            let codePtr := add(creationCode, 0x20)
            let codeLength := mload(creationCode)
            
            // 使用 CREATE
            // value = 0, offset = 内存中代码位置, length = 代码长度
            newContract := create(0, codePtr, codeLength)
        }
        
        createdAddress = newContract;
        return newContract;
    }
    
    // 验证创建的合约
    function verifyCreatedContract() public view returns (uint256) {
        return SimpleStorage(createdAddress).data();
    }
}