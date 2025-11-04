// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 第一个版本的逻辑合约
contract LogicV1 {
    // 存储变量 - 必须仔细规划布局
    address public owner;
    uint256 public value;
    string public name;
    mapping(address => uint256) public balances;
    
    bool private _initialized;
    
    event ValueChanged(uint256 newValue);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    // 初始化函数 - 代替构造函数
    function initialize(address _owner, string memory _name) public {
        require(!_initialized, "Already initialized");
        _initialized = true;
        
        owner = _owner;
        name = _name;
        value = 100;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    function setValue(uint256 _newValue) public onlyOwner {
        value = _newValue;
        emit ValueChanged(_newValue);
    }
    
    function setName(string memory _newName) public onlyOwner {
        name = _newName;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid owner");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
    
    function getVersion() public pure returns (string memory) {
        return "V1.0.0";
    }
}