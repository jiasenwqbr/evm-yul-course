// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 升级版本 - 保持存储布局不变
contract LogicV2 {
    // ⚠️ 必须保持完全相同的存储变量和顺序
    address public owner;
    uint256 public value;
    string public name;
    mapping(address => uint256) public balances;
    
    bool private _initialized;
    
    // ✅ 可以添加新的存储变量（必须在最后）
    uint256 public lastUpdated;
    mapping(address => uint256) public userPoints;
    
    event ValueChanged(uint256 newValue);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event UserRewarded(address indexed user, uint256 points); // 新事件
    
    function initialize(address _owner, string memory _name) public {
        require(!_initialized, "Already initialized");
        _initialized = true;
        
        owner = _owner;
        name = _name;
        value = 100;
        lastUpdated = block.timestamp; // V2 新增初始化
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    // 保持 V1 的所有函数不变
    function setValue(uint256 _newValue) public onlyOwner {
        value = _newValue;
        lastUpdated = block.timestamp; // V2 新增功能
        emit ValueChanged(_newValue);
    }
    
    function setName(string memory _newName) public onlyOwner {
        name = _newName;
    }
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        userPoints[msg.sender] += 1; // V2 新增：存款奖励积分
        emit UserRewarded(msg.sender, 1);
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
    
    // ✅ V2 新增功能
    function rewardUser(address user, uint256 points) public onlyOwner {
        userPoints[user] += points;
        emit UserRewarded(user, points);
    }
    
    function getUserPoints(address user) public view returns (uint256) {
        return userPoints[user];
    }
    
    function updateTimestamp() public {
        lastUpdated = block.timestamp;
    }
    
    function getVersion() public pure returns (string memory) {
        return "V2.0.0";
    }
    
    // 新增功能：批量操作
    function batchRewardUsers(
        address[] memory users, 
        uint256[] memory points
    ) public onlyOwner {
        require(users.length == points.length, "Arrays length mismatch");
        
        for (uint256 i = 0; i < users.length; i++) {
            userPoints[users[i]] += points[i];
            emit UserRewarded(users[i], points[i]);
        }
    }
}