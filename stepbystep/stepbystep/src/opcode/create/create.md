详细解析 Ethereum Virtual Machine (EVM) 中的 `CREATE2` 操作码，包括与 `CREATE` 的详细对比和实际应用示例。

## 1. CREATE2 操作码概述

`CREATE2` 是 **Constantinople 升级** 中引入的操作码，它允许**确定性合约地址生成**。

| 操作码 | 值 | Gas 成本 | 功能 | 栈输入 | 栈输出 |
|--------|-----|----------|------|---------|---------|
| `CREATE2` | `0xf5` | 32000 + 内存扩展成本 | 确定性合约创建 | [value, offset, length, salt] | [address] |

**参数说明**：
- **value**: 发送到新合约的以太币数量（wei）
- **offset**: 初始化代码在内存中的起始位置
- **length**: 初始化代码的字节长度
- **salt**: 用于地址计算的盐值（32字节）

**返回值**：
- 新合约的地址（如果创建成功）
- 0（如果创建失败）

---

## 2. CREATE2 vs CREATE 核心区别

### 地址生成机制对比

| 特性 | CREATE | CREATE2 |
|------|--------|----------|
| **地址依赖** | 发送者地址 + nonce | 发送者地址 + 代码哈希 + salt |
| **确定性** | ❌ 非确定性 | ✅ 确定性 |
| **前置计算** | 不能预先计算地址 | 可以预先计算地址 |
| **重放保护** | nonce | salt |
| **部署顺序** | 必须顺序部署 | 可以任意顺序部署 |

### 地址计算公式

**CREATE 地址**：
```
address = keccak256(rlp([sender_address, sender_nonce]))
```

**CREATE2 地址**：
```
address = keccak256(0xff ++ sender_address ++ salt ++ keccak256(init_code))[12:]
```

---

## 3. CREATE2 地址计算详解

### CREATE2 地址计算公式分解

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Create2AddressCalculator {
    // 计算 CREATE2 地址
    function computeAddress(
        bytes32 salt,
        bytes memory initCode
    ) public view returns (address) {
        bytes32 initCodeHash = keccak256(initCode);
        return computeAddress(salt, initCodeHash);
    }
    
    function computeAddress(
        bytes32 salt,
        bytes32 initCodeHash
    ) public view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 分解计算步骤
    function computeAddressStepByStep(
        bytes32 salt,
        bytes memory initCode
    ) public view returns (bytes32 hash, address computedAddr) {
        // 步骤1: 计算初始化代码的哈希
        bytes32 initCodeHash = keccak256(initCode);
        
        // 步骤2: 构造输入数据
        bytes memory input = abi.encodePacked(
            bytes1(0xff),   // 固定前缀
            address(this),   // 创建者地址
            salt,           // 盐值
            initCodeHash    // 初始化代码哈希
        );
        
        // 步骤3: 计算哈希
        hash = keccak256(input);
        
        // 步骤4: 取最后20字节作为地址
        computedAddr = address(uint160(uint256(hash)));
    }
}
```

---

## 4. 基础 CREATE2 使用示例

### 示例 1：基本 CREATE2 部署

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 将被创建的简单合约
contract SimpleStorage {
    uint256 public data;
    address public creator;
    
    constructor(uint256 _data) {
        data = _data;
        creator = msg.sender;
    }
    
    function setData(uint256 _data) public {
        data = _data;
    }
    
    function getData() public view returns (uint256) {
        return data;
    }
}

contract Create2Basic {
    event ContractCreated(address indexed contractAddress, bytes32 salt, uint256 data);
    
    // 预先计算地址
    function preComputeAddress(
        bytes32 salt,
        uint256 initialData
    ) public view returns (address) {
        // 获取合约的初始化代码（包含构造函数参数）
        bytes memory initCode = type(SimpleStorage).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(initialData));
        
        bytes32 initCodeHash = keccak256(creationCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 使用 CREATE2 部署合约
    function deployWithCreate2(
        bytes32 salt,
        uint256 initialData
    ) public returns (address) {
        // 获取合约字节码（带构造函数参数）
        bytes memory initCode = type(SimpleStorage).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(initialData));
        
        address newContract;
        assembly {
            newContract := create2(0, add(creationCode, 0x20), mload(creationCode), salt)
        }
        
        require(newContract != address(0), "CREATE2 failed");
        
        emit ContractCreated(newContract, salt, initialData);
        return newContract;
    }
    
    // 验证预先计算的地址与实际部署地址是否匹配
    function verifyPrecomputedAddress(
        bytes32 salt,
        uint256 initialData
    ) public returns (bool) {
        address precomputed = preComputeAddress(salt, initialData);
        address actual = deployWithCreate2(salt, initialData);
        
        return precomputed == actual;
    }
}
```

### 示例 2：带 ETH 转账的 CREATE2

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {
    uint256 public balance;
    address public creator;
    
    constructor() payable {
        balance = msg.value;
        creator = msg.sender;
    }
    
    function getBalance() public view returns (uint256) {
        return balance;
    }
    
    function withdraw() public {
        require(msg.sender == creator, "Only creator can withdraw");
        payable(creator).transfer(balance);
        balance = 0;
    }
}

contract Create2WithValue {
    event ContractCreated(address indexed contractAddress, bytes32 salt, uint256 value);
    
    function computeAddress(bytes32 salt) public view returns (address) {
        bytes memory initCode = type(Bank).creationCode;
        bytes32 initCodeHash = keccak256(initCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    function deployBankWithETH(bytes32 salt, uint256 ethAmount) public payable returns (address) {
        require(msg.value >= ethAmount, "Insufficient ETH sent");
        
        bytes memory initCode = type(Bank).creationCode;
        
        address newBank;
        assembly {
            newBank := create2(ethAmount, add(initCode, 0x20), mload(initCode), salt)
        }
        
        require(newBank != address(0), "CREATE2 failed");
        
        // 返还多余的 ETH
        if (address(this).balance > 0) {
            payable(msg.sender).transfer(address(this).balance);
        }
        
        emit ContractCreated(newBank, salt, ethAmount);
        return newBank;
    }
    
    // 检查已部署合约的余额
    function checkDeployedContractBalance(bytes32 salt) public view returns (uint256) {
        address predicted = computeAddress(salt);
        if (predicted.code.length == 0) {
            return 0; // 合约未部署
        }
        return Bank(predicted).getBalance();
    }
}
```

---

## 5. 高级 CREATE2 应用

### 示例 3：状态通道和计数器模式

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 状态通道合约
contract StateChannel {
    address public participant1;
    address public participant2;
    uint256 public balance1;
    uint256 public balance2;
    
    constructor(address _participant1, address _participant2) payable {
        participant1 = _participant1;
        participant2 = _participant2;
        // 初始资金分配
        balance1 = msg.value / 2;
        balance2 = msg.value / 2;
    }
    
    function updateState(uint256 newBalance1, uint256 newBalance2) public {
        require(msg.sender == participant1 || msg.sender == participant2, "Unauthorized");
        require(newBalance1 + newBalance2 == balance1 + balance2, "Invalid balance total");
        balance1 = newBalance1;
        balance2 = newBalance2;
    }
    
    function closeChannel() public {
        require(msg.sender == participant1 || msg.sender == participant2, "Unauthorized");
        payable(participant1).transfer(balance1);
        payable(participant2).transfer(balance2);
        selfdestruct(payable(msg.sender));
    }
}

contract StateChannelFactory {
    event ChannelCreated(address indexed channel, address participant1, address participant2);
    
    // 为特定的参与者对预计算通道地址
    function computeChannelAddress(
        address participant1,
        address participant2
    ) public view returns (address) {
        bytes32 salt = keccak256(abi.encodePacked(participant1, participant2));
        bytes memory initCode = type(StateChannel).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(participant1, participant2));
        
        bytes32 initCodeHash = keccak256(creationCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 创建状态通道
    function createStateChannel(
        address participant2
    ) public payable returns (address) {
        require(msg.value > 0, "Must send ETH to fund channel");
        
        bytes32 salt = keccak256(abi.encodePacked(msg.sender, participant2));
        bytes memory initCode = type(StateChannel).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(msg.sender, participant2));
        
        address newChannel;
        assembly {
            newChannel := create2(callvalue(), add(creationCode, 0x20), mload(creationCode), salt)
        }
        
        require(newChannel != address(0), "CREATE2 failed");
        
        emit ChannelCreated(newChannel, msg.sender, participant2);
        return newChannel;
    }
    
    // 检查通道是否已存在
    function channelExists(address participant1, address participant2) public view returns (bool) {
        address predicted = computeChannelAddress(participant1, participant2);
        return predicted.code.length > 0;
    }
}
```

### 示例 4：合约克隆模式

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 最小代理合约（EIP-1167）
contract MinimalProxy {
    // 这是一个最小代理合约的实现
    // 实际部署时使用字节码
}

contract CloneFactory {
    bytes private constant CLONE_BYTECODE = hex"3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe5af43d82803e903d91602b57fd5bf3";
    
    event CloneCreated(address indexed clone, address indexed implementation);
    
    // 计算克隆合约地址
    function computeCloneAddress(
        address implementation,
        bytes32 salt
    ) public view returns (address) {
        bytes memory cloneCode = generateCloneBytecode(implementation);
        bytes32 initCodeHash = keccak256(abi.encodePacked(cloneCode));
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 生成最小代理字节码
    function generateCloneBytecode(address implementation) public pure returns (bytes memory) {
        bytes20 targetBytes = bytes20(implementation);
        bytes memory clone = new bytes(CLONE_BYTECODE.length);
        
        // 复制模板字节码
        for (uint256 i = 0; i < CLONE_BYTECODE.length; i++) {
            clone[i] = CLONE_BYTECODE[i];
        }
        
        // 替换实现地址
        for (uint256 i = 0; i < 20; i++) {
            clone[10 + i] = targetBytes[i];
        }
        
        return clone;
    }
    
    // 使用 CREATE2 部署克隆
    function createClone(
        address implementation,
        bytes32 salt
    ) public returns (address) {
        bytes memory cloneCode = generateCloneBytecode(implementation);
        
        address clone;
        assembly {
            clone := create2(0, add(cloneCode, 0x20), mload(cloneCode), salt)
        }
        
        require(clone != address(0), "Clone creation failed");
        
        emit CloneCreated(clone, implementation);
        return clone;
    }
    
    // 批量创建克隆
    function createClones(
        address implementation,
        bytes32[] memory salts
    ) public returns (address[] memory) {
        address[] memory clones = new address[](salts.length);
        
        for (uint256 i = 0; i < salts.length; i++) {
            clones[i] = createClone(implementation, salts[i]);
        }
        
        return clones;
    }
}

// 可克隆的业务逻辑合约
contract BusinessLogic {
    uint256 public value;
    address public owner;
    
    event ValueUpdated(uint256 newValue);
    
    function initialize() public {
        owner = msg.sender;
        value = 42;
    }
    
    function setValue(uint256 newValue) public {
        require(msg.sender == owner, "Only owner can set value");
        value = newValue;
        emit ValueUpdated(newValue);
    }
    
    function getValue() public view returns (uint256) {
        return value;
    }
}
```

---

## 6. CREATE2 的实际应用场景

### 示例 5：计数器合约工厂

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 public count;
    address public owner;
    string public name;
    
    constructor(string memory _name) {
        count = 0;
        owner = msg.sender;
        name = _name;
    }
    
    function increment() public {
        count++;
    }
    
    function decrement() public {
        require(count > 0, "Counter: decrement overflow");
        count--;
    }
    
    function reset() public {
        require(msg.sender == owner, "Only owner can reset");
        count = 0;
    }
    
    function getInfo() public view returns (string memory, uint256, address) {
        return (name, count, owner);
    }
}

contract CounterFactory {
    struct CounterInfo {
        address counterAddress;
        string name;
        address owner;
        uint256 createdAt;
    }
    
    mapping(bytes32 => CounterInfo) public counters;
    bytes32[] public allSalts;
    
    event CounterCreated(address indexed counter, string name, bytes32 salt);
    
    // 预计算计数器地址
    function preComputeCounterAddress(
        string memory name,
        bytes32 salt
    ) public view returns (address) {
        bytes memory initCode = type(Counter).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(name));
        
        bytes32 initCodeHash = keccak256(creationCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 使用 CREATE2 创建计数器
    function createCounter(
        string memory name,
        bytes32 salt
    ) public returns (address) {
        // 检查是否已存在
        require(counters[salt].counterAddress == address(0), "Counter already exists");
        
        bytes memory initCode = type(Counter).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(name));
        
        address newCounter;
        assembly {
            newCounter := create2(0, add(creationCode, 0x20), mload(creationCode), salt)
        }
        
        require(newCounter != address(0), "CREATE2 failed");
        
        // 记录计数器信息
        counters[salt] = CounterInfo({
            counterAddress: newCounter,
            name: name,
            owner: msg.sender,
            createdAt: block.timestamp
        });
        allSalts.push(salt);
        
        emit CounterCreated(newCounter, name, salt);
        return newCounter;
    }
    
    // 使用用户名作为盐值创建计数器
    function createCounterWithUsername(string memory username) public returns (address) {
        bytes32 salt = keccak256(abi.encodePacked(msg.sender, username));
        return createCounter(username, salt);
    }
    
    // 获取用户的所有计数器
    function getUserCounters(address user) public view returns (CounterInfo[] memory) {
        uint256 userCounterCount = 0;
        
        // 首先计算用户拥有的计数器数量
        for (uint256 i = 0; i < allSalts.length; i++) {
            if (counters[allSalts[i]].owner == user) {
                userCounterCount++;
            }
        }
        
        // 然后收集计数器信息
        CounterInfo[] memory userCounters = new CounterInfo[](userCounterCount);
        uint256 currentIndex = 0;
        
        for (uint256 i = 0; i < allSalts.length; i++) {
            if (counters[allSalts[i]].owner == user) {
                userCounters[currentIndex] = counters[allSalts[i]];
                currentIndex++;
            }
        }
        
        return userCounters;
    }
    
    // 检查计数器是否存在
    function counterExists(bytes32 salt) public view returns (bool) {
        return counters[salt].counterAddress != address(0);
    }
    
    // 获取所有计数器数量
    function getTotalCounters() public view returns (uint256) {
        return allSalts.length;
    }
}
```

### 示例 6：CREATE2 在 DeFi 中的应用

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract FlashLoanReceiver {
    address public owner;
    address public factory;
    uint256 public lastLoanAmount;
    
    constructor(address _owner) {
        owner = _owner;
        factory = msg.sender;
    }
    
    function executeOperation(
        address token,
        uint256 amount,
        uint256 premium,
        bytes calldata params
    ) external returns (bool) {
        // 这里实现闪电贷逻辑
        lastLoanAmount = amount + premium;
        
        // 必须返回成功
        return true;
    }
    
    // 只有工厂可以调用
    modifier onlyFactory() {
        require(msg.sender == factory, "Only factory can call");
        _;
    }
}

contract FlashLoanFactory {
    event ReceiverCreated(address indexed receiver, address indexed owner, bytes32 salt);
    
    // 预计算接收器地址
    function computeReceiverAddress(
        address owner,
        bytes32 salt
    ) public view returns (address) {
        bytes memory initCode = type(FlashLoanReceiver).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(owner));
        
        bytes32 initCodeHash = keccak256(creationCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 为特定用户创建确定的接收器
    function createReceiver(bytes32 salt) public returns (address) {
        address predicted = computeReceiverAddress(msg.sender, salt);
        
        // 如果已经存在，直接返回地址
        if (predicted.code.length > 0) {
            return predicted;
        }
        
        bytes memory initCode = type(FlashLoanReceiver).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(msg.sender));
        
        address receiver;
        assembly {
            receiver := create2(0, add(creationCode, 0x20), mload(creationCode), salt)
        }
        
        require(receiver != address(0), "CREATE2 failed");
        
        emit ReceiverCreated(receiver, msg.sender, salt);
        return receiver;
    }
    
    // 批量创建接收器
    function createReceivers(bytes32[] memory salts) public returns (address[] memory) {
        address[] memory receivers = new address[](salts.length);
        
        for (uint256 i = 0; i < salts.length; i++) {
            receivers[i] = createReceiver(salts[i]);
        }
        
        return receivers;
    }
    
    // 获取用户的接收器
    function getUserReceiver(address user, bytes32 salt) public view returns (address) {
        return computeReceiverAddress(user, salt);
    }
}
```

---

## 7. CREATE2 与 CREATE 的详细对比

### 对比测试合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestContract {
    uint256 public value;
    address public creator;
    
    constructor(uint256 _value) {
        value = _value;
        creator = msg.sender;
    }
}

contract CreateVsCreate2 {
    event CreatedWithCreate(address contractAddress, uint256 nonce);
    event CreatedWithCreate2(address contractAddress, bytes32 salt);
    
    uint256 public createCount = 0;
    mapping(bytes32 => bool) public create2Deployments;
    
    // CREATE 部署
    function deployWithCreate(uint256 value) public returns (address) {
        bytes memory initCode = type(TestContract).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(value));
        
        address newContract;
        assembly {
            newContract := create(0, add(creationCode, 0x20), mload(creationCode))
        }
        
        require(newContract != address(0), "CREATE failed");
        
        createCount++;
        emit CreatedWithCreate(newContract, createCount - 1);
        return newContract;
    }
    
    // CREATE2 部署
    function deployWithCreate2(bytes32 salt, uint256 value) public returns (address) {
        require(!create2Deployments[salt], "Salt already used");
        
        bytes memory initCode = type(TestContract).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(value));
        
        address newContract;
        assembly {
            newContract := create2(0, add(creationCode, 0x20), mload(creationCode), salt)
        }
        
        require(newContract != address(0), "CREATE2 failed");
        
        create2Deployments[salt] = true;
        emit CreatedWithCreate2(newContract, salt);
        return newContract;
    }
    
    // 预计算 CREATE2 地址
    function precomputeCreate2Address(bytes32 salt, uint256 value) public view returns (address) {
        bytes memory initCode = type(TestContract).creationCode;
        bytes memory creationCode = abi.encodePacked(initCode, abi.encode(value));
        
        bytes32 initCodeHash = keccak256(creationCode);
        
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            initCodeHash
        )))));
    }
    
    // 比较两种方法的地址确定性
    function compareDeterminism() public returns (bool) {
        // CREATE - 每次部署地址都不同
        address createAddr1 = deployWithCreate(100);
        address createAddr2 = deployWithCreate(100);
        bool createIsDeterministic = (createAddr1 == createAddr2);
        
        // CREATE2 - 相同盐值产生相同地址
        bytes32 salt = keccak256("test-salt");
        address create2Precomputed = precomputeCreate2Address(salt, 100);
        address create2Actual = deployWithCreate2(salt, 100);
        bool create2IsDeterministic = (create2Precomputed == create2Actual);
        
        return (!createIsDeterministic && create2IsDeterministic);
    }
    
    // 测试重新部署到相同地址
    function testRedeployment(bytes32 salt) public returns (bool) {
        // 第一次部署
        address firstDeployment = deployWithCreate2(salt, 100);
        
        // 尝试第二次部署（应该失败）
        try this.deployWithCreate2(salt, 200) returns (address secondDeployment) {
            return false; // 不应该成功
        } catch {
            return true; // 应该失败
        }
    }
}
```

## 8. 重要注意事项和最佳实践

### 安全注意事项

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Create2Security {
    /*
    CREATE2 安全最佳实践：
    
    1. 盐值管理：确保盐值的唯一性和不可预测性
    2. 重放保护：防止同一盐值被重复使用
    3. 初始化验证：验证部署的合约代码符合预期
    4. 访问控制：限制谁可以调用 CREATE2
    5. 前置计算验证：验证预计算地址与实际部署地址匹配
    */
    
    mapping(bytes32 => bool) public usedSalts;
    
    event SafeDeployment(address contractAddress, bytes32 salt, bytes32 initCodeHash);
    
    modifier onlyUniqueSalt(bytes32 salt) {
        require(!usedSalts[salt], "Salt already used");
        _;
        usedSalts[salt] = true;
    }
    
    function safeCreate2Deploy(
        bytes32 salt,
        bytes memory initCode,
        bytes32 expectedInitCodeHash
    ) public onlyUniqueSalt(salt) returns (address) {
        // 验证初始化代码哈希
        bytes32 actualInitCodeHash = keccak256(initCode);
        require(actualInitCodeHash == expectedInitCodeHash, "Init code hash mismatch");
        
        // 预计算地址
        address predicted = address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            actualInitCodeHash
        )))));
        
        // 部署合约
        address newContract;
        assembly {
            newContract := create2(0, add(initCode, 0x20), mload(initCode), salt)
        }
        
        require(newContract != address(0), "CREATE2 failed");
        require(newContract == predicted, "Address prediction failed");
        
        emit SafeDeployment(newContract, salt, actualInitCodeHash);
        return newContract;
    }
    
    // 生成安全的盐值
    function generateSecureSalt(
        address user,
        uint256 nonce,
        bytes memory context
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(user, nonce, context, block.chainid));
    }
}
```

## 总结

**CREATE2 核心优势**：

1. **确定性地址**: 可以预先计算合约地址
2. **无状态依赖**: 不依赖 nonce，可以任意顺序部署
3. **跨链兼容**: 可以在不同链上部署到相同地址
4. **模式创新**: 支持状态通道、计数器模式等新应用

**主要应用场景**：
- **状态通道**: 为特定参与者对预计算通道地址
- **合约克隆**: 部署多个代理合约到可预测地址
- **用户合约**: 为每个用户部署独立的合约实例
- **升级模式**: 实现更复杂的合约升级策略
- **跨链应用**: 在不同链上部署相同地址的合约

**与 CREATE 的关键区别**：

| 方面 | CREATE | CREATE2 |
|------|--------|----------|
| 地址确定性 | ❌ 非确定性 | ✅ 确定性 |
| 前置计算 | ❌ 不可能 | ✅ 可能 |
| 部署顺序 | ✅ 必须顺序 | ❌ 任意顺序 |
| 重放保护 | nonce | salt |
| 适用场景 | 常规部署 | 高级模式 |

**最佳实践**：
1. 使用安全的盐值生成策略
2. 验证初始化代码哈希
3. 实现重放保护机制
4. 验证预计算地址与实际地址匹配
5. 考虑使用访问控制限制部署权限

CREATE2 为以太坊智能合约开发带来了革命性的可能性，特别是在需要确定性地址和跨链兼容性的复杂应用场景中。