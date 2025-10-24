详细解析 Ethereum Virtual Machine (EVM) 中的 `SELFDESTRUCT` 操作码。这是一个非常重要且具有破坏性的操作码。

## 1. SELFDESTRUCT 操作码概述

`SELFDESTRUCT`（原名 `SUICIDE`）允许合约自我销毁并将其剩余的 ETH 余额发送到指定地址。

| 操作码 | 值 | Gas 成本 | 功能 | 栈输入 | 栈输出 |
|--------|-----|----------|------|---------|---------|
| `SELFDESTRUCT` | `0xff` | 5000（EIP-3529后） | 销毁合约并转移余额 | [beneficiary] | - |

**栈输入参数**：
- **beneficiary**: 接收合约剩余 ETH 的地址

**Gas 成本历史**：
- 最初：5000 Gas
- EIP-3529 后：增加了 Gas 返还的复杂性
- 未来：可能在某些情况下变为 0（EIP-4758 提案）

**效果**：
- 合约代码和存储被删除
- 合约地址的 ETH 余额转移到受益人地址
- 合约地址变为"空地址"（但历史记录保留）

---

## 2. SELFDESTRUCT 的核心特性

### 关键行为特征

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SelfDestructBehavior {
    address public owner;
    uint256 public importantData;
    
    constructor() {
        owner = msg.sender;
        importantData = 42;
    }
    
    // 存储一些数据
    function setData(uint256 data) public {
        importantData = data;
    }
    
    // 接收 ETH
    receive() external payable {}
    
    function demonstrateSelfDestruct() public {
        require(msg.sender == owner, "Only owner can destroy");
        
        // 自毁前的状态
        address self = address(this);
        uint256 balance = self.balance;
        uint256 data = importantData;
        
        // 执行自毁
        selfdestruct(payable(owner));
        
        // 以下代码不会执行
        importantData = 0;
    }
}
```

### SELFDESTRUCT 后的状态

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PostSelfDestructChecker {
    function checkContractState(address target) public view returns (
        bool hasCode,
        uint256 codeSize,
        uint256 balance
    ) {
        hasCode = target.code.length > 0;
        codeSize = target.code.length;
        balance = target.balance;
        return (hasCode, codeSize, balance);
    }
    
    function testSelfDestructBehavior() public {
        // 创建一个临时合约
        TempContract temp = new TempContract();
        address tempAddress = address(temp);
        
        // 发送一些 ETH 到临时合约
        payable(tempAddress).transfer(1 ether);
        
        // 检查自毁前的状态
        (bool hasCodeBefore, uint256 codeSizeBefore, uint256 balanceBefore) = 
            checkContractState(tempAddress);
        
        // 触发自毁
        temp.destroy();
        
        // 检查自毁后的状态
        (bool hasCodeAfter, uint256 codeSizeAfter, uint256 balanceAfter) = 
            checkContractState(tempAddress);
        
        // 结果：
        // hasCodeBefore = true, codeSizeBefore > 0, balanceBefore = 1 ether
        // hasCodeAfter = false, codeSizeAfter = 0, balanceAfter = 0
    }
}

contract TempContract {
    uint256 public data = 100;
    
    receive() external payable {}
    
    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}
```

---

## 3. 基础 SELFDESTRUCT 使用示例

### 示例 1：基本自毁模式

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BasicSelfDestruct {
    address public owner;
    string public contractName;
    uint256 public creationTime;
    
    event ContractDestroyed(address indexed beneficiary, uint256 amount);
    
    constructor(string memory name) {
        owner = msg.sender;
        contractName = name;
        creationTime = block.timestamp;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 接收 ETH
    receive() external payable {}
    
    // 基本的自毁函数
    function destroy() public onlyOwner {
        uint256 balance = address(this).balance;
        address beneficiary = owner;
        
        emit ContractDestroyed(beneficiary, balance);
        selfdestruct(payable(beneficiary));
    }
    
    // 自毁到指定地址
    function destroyTo(address beneficiary) public onlyOwner {
        require(beneficiary != address(0), "Invalid beneficiary address");
        
        uint256 balance = address(this).balance;
        emit ContractDestroyed(beneficiary, balance);
        selfdestruct(payable(beneficiary));
    }
    
    // 带条件检查的自毁
    function conditionalDestroy(uint256 minBalance) public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance >= minBalance, "Balance too low for destruction");
        
        emit ContractDestroyed(owner, balance);
        selfdestruct(payable(owner));
    }
    
    // 获取合约信息
    function getContractInfo() public view returns (
        string memory name,
        address contractOwner,
        uint256 balance,
        uint256 age
    ) {
        return (
            contractName,
            owner,
            address(this).balance,
            block.timestamp - creationTime
        );
    }
}
```

### 示例 2：紧急情况下的自毁

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmergencySelfDestruct {
    address public owner;
    address public emergencyAdmin;
    bool public emergencyMode = false;
    uint256 public emergencyTime;
    
    mapping(address => uint256) public userBalances;
    uint256 public totalLocked;
    
    event EmergencyActivated(uint256 timestamp);
    event EmergencyDeactivated(uint256 timestamp);
    contract EmergencySelfDestruct {
    address public owner;
    address public emergencyAdmin;
    bool public emergencyMode = false;
    uint256 public emergencyTime;
    
    mapping(address => uint256) public userBalances;
    uint256 public totalLocked;
    
    event EmergencyActivated(uint256 timestamp);
    event EmergencyDeactivated(uint256 timestamp);
    event FundsRecovered(address indexed user, uint256 amount);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    modifier onlyEmergencyAdmin() {
        require(msg.sender == emergencyAdmin, "Only emergency admin");
        _;
    }
    
    modifier onlyInEmergency() {
        require(emergencyMode, "Not in emergency mode");
        _;
    }
    
    constructor(address _emergencyAdmin) {
        owner = msg.sender;
        emergencyAdmin = _emergencyAdmin;
    }
    
    // 用户存款
    function deposit() public payable {
        require(!emergencyMode, "Contract in emergency mode");
        userBalances[msg.sender] += msg.value;
        totalLocked += msg.value;
    }
    
    // 用户取款
    function withdraw(uint256 amount) public {
        require(!emergencyMode, "Contract in emergency mode");
        require(userBalances[msg.sender] >= amount, "Insufficient balance");
        
        userBalances[msg.sender] -= amount;
        totalLocked -= amount;
        payable(msg.sender).transfer(amount);
    }
    
    // 激活紧急模式
    function activateEmergency() public onlyEmergencyAdmin {
        require(!emergencyMode, "Already in emergency mode");
        
        emergencyMode = true;
        emergencyTime = block.timestamp;
        emit EmergencyActivated(emergencyTime);
    }
    
    // 解除紧急模式
    function deactivateEmergency() public onlyEmergencyAdmin onlyInEmergency {
        emergencyMode = false;
        emit EmergencyDeactivated(block.timestamp);
    }
    
    // 紧急模式下用户恢复资金
    function emergencyWithdraw() public onlyInEmergency {
        uint256 userBalance = userBalances[msg.sender];
        require(userBalance > 0, "No balance to recover");
        
        userBalances[msg.sender] = 0;
        totalLocked -= userBalance;
        
        payable(msg.sender).transfer(userBalance);
        emit FundsRecovered(msg.sender, userBalance);
    }
    
    // 终极紧急自毁 - 只有在极端情况下使用
    function emergencySelfDestruct() public onlyEmergencyAdmin onlyInEmergency {
        // 只有在紧急模式激活后一段时间才能自毁
        require(block.timestamp >= emergencyTime + 1 days, "Emergency cooldown not passed");
        
        // 检查是否所有用户都已恢复资金
        require(totalLocked == 0, "Not all funds recovered by users");
        
        uint256 remainingBalance = address(this).balance;
        selfdestruct(payable(emergencyAdmin));
    }
    
    // 更新紧急管理员
    function updateEmergencyAdmin(address newAdmin) public onlyOwner {
        require(newAdmin != address(0), "Invalid admin address");
        emergencyAdmin = newAdmin;
    }
    
    // 获取紧急状态信息
    function getEmergencyInfo() public view returns (
        bool isEmergency,
        uint256 activatedTime,
        uint256 timeInEmergency,
        uint256 remainingLocked
    ) {
        return (
            emergencyMode,
            emergencyTime,
            emergencyMode ? block.timestamp - emergencyTime : 0,
            totalLocked
        );
    }
}
```

---

## 4. 高级 SELFDESTRUCT 应用

### 示例 3：可升级合约中的自毁模式

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UpgradeableWithSelfDestruct {
    address public implementation;
    address public admin;
    address public recoveryAddress;
    bool public initialized = false;
    
    event Upgraded(address newImplementation);
    event RecoveryModeActivated();
    event ContractDestroyed(uint256 amountRecovered);
    
    error NotAdmin();
    error NotRecoveryAddress();
    error AlreadyInitialized();
    error InvalidImplementation();
    
    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }
    
    modifier onlyRecovery() {
        if (msg.sender != recoveryAddress) revert NotRecoveryAddress();
        _;
    }
    
    constructor(address _admin, address _recoveryAddress) {
        admin = _admin;
        recoveryAddress = _recoveryAddress;
        initialized = true;
    }
    
    function initialize(address _admin, address _recoveryAddress) public {
        if (initialized) revert AlreadyInitialized();
        admin = _admin;
        recoveryAddress = _recoveryAddress;
        initialized = true;
    }
    
    function upgrade(address newImplementation) public onlyAdmin {
        if (newImplementation.code.length == 0) revert InvalidImplementation();
        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }
    
    // 恢复模式自毁 - 只有在私钥丢失等极端情况下使用
    function recoverySelfDestruct() public onlyRecovery {
        emit RecoveryModeActivated();
        
        uint256 balance = address(this).balance;
        emit ContractDestroyed(balance);
        
        selfdestruct(payable(recoveryAddress));
    }
    
    // 正常管理自毁
    function adminSelfDestruct() public onlyAdmin {
        uint256 balance = address(this).balance;
        emit ContractDestroyed(balance);
        
        selfdestruct(payable(admin));
    }
    
    // 回退函数
    fallback() external payable {
        address impl = implementation;
        require(impl != address(0), "Implementation not set");
        
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    
    receive() external payable {}
}
```

### 示例 4：定时器自毁合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockedSelfDestruct {
    address public owner;
    uint256 public unlockTime;
    uint256 public creationTime;
    bool public destroyed = false;
    
    event FundsDeposited(address from, uint256 amount);
    event DestructionScheduled(uint256 unlockTime);
    contract TimeLockedSelfDestruct {
    address public owner;
    uint256 public unlockTime;
    uint256 public creationTime;
    bool public destroyed = false;
    
    event FundsDeposited(address from, uint256 amount);
    event DestructionScheduled(uint256 unlockTime);
    event ContractDestroyed(address beneficiary, uint256 amount);
    event DestructionCancelled();
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    modifier notDestroyed() {
        require(!destroyed, "Contract already destroyed");
        _;
    }
    
    constructor(uint256 _lockDuration) {
        owner = msg.sender;
        creationTime = block.timestamp;
        unlockTime = block.timestamp + _lockDuration;
        emit DestructionScheduled(unlockTime);
    }
    
    // 接收存款
    receive() external payable notDestroyed {
        emit FundsDeposited(msg.sender, msg.value);
    }
    
    // 检查是否可以自毁
    function canSelfDestruct() public view returns (bool) {
        return block.timestamp >= unlockTime && !destroyed;
    }
    
    // 执行自毁
    function executeSelfDestruct() public onlyOwner notDestroyed {
        require(block.timestamp >= unlockTime, "Lock time not reached");
        
        uint256 balance = address(this).balance;
        destroyed = true;
        
        emit ContractDestroyed(owner, balance);
        selfdestruct(payable(owner));
    }
    
    // 延长锁定时长
    function extendLockTime(uint256 additionalTime) public onlyOwner notDestroyed {
        require(additionalTime > 0, "Additional time must be positive");
        unlockTime += additionalTime;
        emit DestructionScheduled(unlockTime);
    }
    
    // 取消自毁计划
    function cancelSelfDestruct() public onlyOwner notDestroyed {
        unlockTime = type(uint256).max; //  effectively cancel
        emit DestructionCancelled();
    }
    
    // 紧急自毁（需要多签）
    function emergencySelfDestruct(address[3] memory signers, bytes[3] memory signatures) 
        public 
        notDestroyed 
    {
        require(verifySignatures(signers, signatures), "Invalid signatures");
        
        uint256 balance = address(this).balance;
        destroyed = true;
        
        emit ContractDestroyed(owner, balance);
        selfdestruct(payable(owner));
    }
    
    // 简单的多签验证（简化版）
    function verifySignatures(address[3] memory signers, bytes[3] memory signatures) 
        internal 
        view 
        returns (bool) 
    {
        bytes32 messageHash = keccak256(abi.encodePacked("EMERGENCY_SELFDESTRUCT", address(this)));
        
        for (uint256 i = 0; i < 3; i++) {
            address recovered = recoverSigner(messageHash, signatures[i]);
            if (recovered != signers[i]) {
                return false;
            }
        }
        
        return true;
    }
    
    // 恢复签名者（简化版）
    function recoverSigner(bytes32 messageHash, bytes memory signature) 
        internal 
        pure 
        returns (address) 
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        return ecrecover(messageHash, v, r, s);
    }
    
    function splitSignature(bytes memory sig) 
        internal 
        pure 
        returns (bytes32 r, bytes32 s, uint8 v) 
    {
        require(sig.length == 65, "Invalid signature length");
        
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
        
        if (v < 27) v += 27;
    }
    
    // 获取合约状态信息
    function getContractState() public view returns (
        uint256 currentBalance,
        uint256 timeUntilUnlock,
        bool canDestroy,
        bool isDestroyed
    ) {
        return (
            address(this).balance,
            block.timestamp < unlockTime ? unlockTime - block.timestamp : 0,
            canSelfDestruct(),
            destroyed
        );
    }
}
```

---

## 5. SELFDESTRUCT 的安全考虑和陷阱

### 示例 5：SELFDESTRUCT 的安全陷阱

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SelfDestructPitfalls {
    address public owner;
    mapping(address => uint256) public balances;
    
    event FundsLost(address user, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    // 陷阱1：自毁后仍然可以调用函数
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance");
        
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
    
    function dangerousSelfDestruct() public {
        require(msg.sender == owner, "Only owner");
        
        // 自毁合约
        selfdestruct(payable(owner));
        
        // 陷阱：自毁后的代码仍然会执行！
        // 这会导致资金被锁定
        uint256 contractBalance = address(this).balance;
        if (contractBalance > 0) {
            // 这里的转账永远不会发生，因为合约已经自毁
            payable(owner).transfer(contractBalance);
        }
    }
    
    // 正确的自毁方式
    function safeSelfDestruct() public {
        require(msg.sender == owner, "Only owner");
        
        // 1. 首先处理用户资金
        refundAllUsers();
        
        // 2. 然后自毁
        selfdestruct(payable(owner));
    }
    
    function refundAllUsers() internal {
        // 实现用户退款逻辑
        // 这里需要遍历所有用户并退款
    }
}

// 演示自毁后的行为
contract SelfDestructTester {
    address public createdContract;
    
    function createAndDestroy() public {
        // 创建临时合约
        TempContract temp = new TempContract();
        createdContract = address(temp);
        
        // 发送 ETH 到合约
        payable(createdContract).transfer(1 ether);
        
        // 自毁合约
        temp.destroy();
        
        // 尝试调用自毁后的合约
        (bool success, ) = createdContract.call(
            abi.encodeWithSignature("getBalance()")
        );
        
        // success = false，因为合约已自毁
    }
    
    function checkContractState() public view returns (
        bool hasCode,
        uint256 codeSize,
        uint256 balance
    ) {
        hasCode = createdContract.code.length > 0;
        codeSize = createdContract.code.length;
        balance = createdContract.balance;
        return (hasCode, codeSize, balance);
    }
}

contract TempContract {
    uint256 public value = 42;
    
    receive() external payable {}
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}
```

### 示例 6：SELFDESTRUCT 与代理模式的交互

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProxyPatternWithSelfDestruct {
    address public implementation;
    address public admin;
    
    event Upgraded(address newImplementation);
    event SelfDestructInitiated();
    
    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }
    
    function upgrade(address newImplementation) public onlyAdmin {
        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }
    
    // 危险：如果实现合约自毁，代理合约会怎样？
    fallback() external payable {
        address impl = implementation;
        
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    
    receive() external payable {}
    
    // 安全的自毁检查
    function checkImplementation() public view returns (
        bool hasCode,
        uint256 codeSize,
        bool isContract
    ) {
        hasCode = implementation.code.length > 0;
        codeSize = implementation.code.length;
        isContract = implementation != address(0) && hasCode;
        return (hasCode, codeSize, isContract);
    }
}

// 可能自毁的实现合约
contract DestructibleImplementation {
    address public owner;
    bool public selfDestructEnabled = false;
    
    event SelfDestructWarning();
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    function enableSelfDestruct() public onlyOwner {
        selfDestructEnabled = true;
        emit SelfDestructWarning();
    }
    
    function safeFunction() public view returns (string memory) {
        return "This is a safe function";
    }
    
    function dangerousFunction() public onlyOwner {
        require(selfDestructEnabled, "Self destruct not enabled");
        
        // 如果通过代理调用，这会自毁实现合约，而不是代理合约
        selfdestruct(payable(owner));
    }
    
    // 接收 ETH
    receive() external payable {}
}
```

---

## 6. EIP-4758 和 SELFDESTRUCT 的未来

### SELFDESTRUCT 的演变和弃用计划

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * EIP-4758 对 SELFDESTRUCT 的修改：
 * 
 * 1. 删除 SELFDESTRUCT 操作码的功能
 * 2. 将其变为 SENDALL 操作码，只转移余额不删除代码
 * 3. 目的是提高网络效率和安全性
 * 
 * 当前最佳实践：避免依赖 SELFDESTRUCT
 */
contract SelfDestructFuture {
    address public owner;
    bool public deprecated = false;
    
    event DeprecationWarning(string message);
    
    constructor() {
        owner = msg.sender;
    }
    
    // 现代替代方案：不使用 SELFDESTRUCT
    function emergencyWithdraw() public {
        require(msg.sender == owner, "Only owner");
        
        // 发出弃用警告
        emit DeprecationWarning("SELFDESTRUCT is deprecated. Using alternative method.");
        
        // 替代方案1：转移所有余额但不自毁
        uint256 balance = address(this).balance;
        if (balance > 0) {
            payable(owner).transfer(balance);
        }
        
        // 替代方案2：标记合约为弃用状态
        deprecated = true;
    }
    
    // 检查合约是否已弃用
    function isDeprecated() public view returns (bool) {
        return deprecated;
    }
    
    // 现代模式：使用暂停机制而不是自毁
    function pauseContract() public {
        require(msg.sender == owner, "Only owner");
        deprecated = true;
        emit DeprecationWarning("Contract paused instead of self-destructed");
    }
    
    // 只有未弃用时可以调用
    modifier whenNotDeprecated() {
        require(!deprecated, "Contract is deprecated");
        _;
    }
    
    function normalOperation() public whenNotDeprecated returns (string memory) {
        return "Normal operation";
    }
    
    receive() external payable whenNotDeprecated {}
}
```

## 7. 重要注意事项和最佳实践

### 安全最佳实践

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SelfDestructBestPractices {
    /*
    SELFDESTRUCT 最佳实践：
    
    1. 避免使用：在大多数情况下，有更好的替代方案
    2. 多重保护：使用多签或时间锁
    3. 资金处理：自毁前确保处理所有用户资金
    4. 状态清理：自毁前清理所有重要状态
    5. 事件记录：记录自毁事件以便审计
    6. 权限控制：严格限制自毁权限
    */
    
    address public owner;
    address public multiSig;
    uint256 public unlockTime;
    bool public selfDestructInitiated = false;
    
    event SelfDestructScheduled(uint256 unlockTime);
    event SelfDestructCancelled();
    event FundsRecovered(address indexed user, uint256 amount);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    modifier onlyMultiSig() {
        require(msg.sender == multiSig, "Only multiSig");
        _;
    }
    
    constructor(address _multiSig) {
        owner = msg.sender;
        multiSig = _multiSig;
    }
    
    // 安全的自毁流程
    function initiateSelfDestruct(uint256 delay) public onlyMultiSig {
        require(!selfDestructInitiated, "Already initiated");
        
        unlockTime = block.timestamp + delay;
        selfDestructInitiated = true;
        
        emit SelfDestructScheduled(unlockTime);
    }
    
    function cancelSelfDestruct() public onlyMultiSig {
        require(selfDestructInitiated, "Not initiated");
        
        selfDestructInitiated = false;
        unlockTime = 0;
        
        emit SelfDestructCancelled();
    }
    
    function executeSelfDestruct() public onlyMultiSig {
        require(selfDestructInitiated, "Not initiated");
        require(block.timestamp >= unlockTime, "Time lock not expired");
        require(address(this).balance == 0, "Contract still has funds");
        
        // 最终检查：确保所有条件都满足
        performFinalChecks();
        
        selfdestruct(payable(multiSig));
    }
    
    function performFinalChecks() internal view {
        // 实现最终检查逻辑
        require(address(this).balance == 0, "Balance should be zero");
        // 添加其他必要的检查
    }
    
    // 资金恢复函数
    function recoverFunds(address[] memory users) public onlyOwner {
        for (uint256 i = 0; i < users.length; i++) {
            // 实现资金恢复逻辑
            emit FundsRecovered(users[i], 0); // 示例
        }
    }
    
    // 获取自毁状态
    function getSelfDestructStatus() public view returns (
        bool initiated,
        uint256 timeRemaining,
        bool canExecute
    ) {
        return (
            selfDestructInitiated,
            selfDestructInitiated && block.timestamp < unlockTime ? unlockTime - block.timestamp : 0,
            selfDestructInitiated && block.timestamp >= unlockTime && address(this).balance == 0
        );
    }
}
```

## 总结

**SELFDESTRUCT 关键特性**：

1. **不可逆操作**: 一旦执行无法撤销
2. **资金转移**: 将所有 ETH 转移到指定地址
3. **代码删除**: 合约代码被从区块链状态中移除
4. **Gas 成本**: 固定 5000 Gas（EIP-3529 后）

**主要应用场景**：
- 紧急情况下的资金恢复
- 合约生命周期结束
- 私钥丢失恢复
- 临时合约清理

**安全风险**：
- ❌ 用户资金可能被永久锁定
- ❌ 代理模式中的意外行为
- ❌ 无法撤销的破坏性操作
- ❌ 可能被恶意利用

**现代替代方案**：
- 使用暂停机制而不是自毁
- 实现资金提取函数
- 使用时间锁和多签
- 标记合约为弃用状态

**最佳实践**：
1. **避免使用**: 在大多数情况下不需要 SELFDESTRUCT
2. **多重保护**: 使用多签和时间锁
3. **资金安全**: 确保所有用户资金已处理
4. **事件记录**: 完整记录自毁过程
5. **权限控制**: 严格限制访问权限

**未来发展**：
- EIP-4758 提议将 SELFDESTRUCT 改为 SENDALL
- 未来可能完全移除或修改其行为
- 建议在新项目中避免依赖 SELFDESTRUCT

SELFDESTRUCT 是一个强大的操作码，但由于其破坏性和潜在的安全风险，在现代智能合约开发中应该谨慎使用，并优先考虑更安全的替代方案。