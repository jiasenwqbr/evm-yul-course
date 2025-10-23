// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    address public owner;
    
    constructor(string memory _name, string memory _symbol, uint256 _supply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _supply;
        owner = msg.sender;
    }
}

contract TokenFactory {
    address[] public allTokens;
    mapping(address => bool) public isToken;
    
    event TokenCreated(address indexed tokenAddress, string name, string symbol);
    
    function createToken(
        string memory name, 
        string memory symbol, 
        uint256 supply
    ) public returns (address) {
        bytes memory bytecode = type(Token).creationCode;
        bytes memory creationCode = abi.encodePacked(
            bytecode, 
            abi.encode(name, symbol, supply)
        );
        
        address newToken;
        assembly {
            let codePtr := add(creationCode, 0x20)
            let codeLength := mload(creationCode)
            newToken := create(0, codePtr, codeLength)
        }
        
        require(newToken != address(0), "Token creation failed");
        
        allTokens.push(newToken);
        isToken[newToken] = true;
        
        emit TokenCreated(newToken, name, symbol);
        return newToken;
    }
    
    function createMultipleTokens(
        string[] memory names,
        string[] memory symbols, 
        uint256[] memory supplies
    ) public returns (address[] memory) {
        require(
            names.length == symbols.length && names.length == supplies.length,
            "Arrays length mismatch"
        );
        
        address[] memory createdTokens = new address[](names.length);
        
        for (uint256 i = 0; i < names.length; i++) {
            createdTokens[i] = createToken(names[i], symbols[i], supplies[i]);
        }
        
        return createdTokens;
    }
    
    function getTokenCount() public view returns (uint256) {
        return allTokens.length;
    }
}