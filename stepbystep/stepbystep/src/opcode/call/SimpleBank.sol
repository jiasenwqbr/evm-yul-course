// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 目标合约 - 模拟一个简单的银行合约
contract SimpleBank {
    mapping(address => uint256) public balances;
    
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
    
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
}

contract CallWithData {
    event CallExecuted(address target, bool success, bytes returnData);
    
    // 使用 CALL 调用 deposit 函数
    function callDeposit(address bankAddress, uint256 amount) public returns (bool) {
        bool success;
        
        // deposit() 函数的选择器
        bytes4 depositSelector = bytes4(keccak256("deposit()"));
        
        assembly {
            // 在内存中准备调用数据
            mstore(0x00, depositSelector)  // 函数选择器
            
            // 执行 CALL - 发送 ETH 但不传递额外调用数据
            success := call(
                gas(),                      // gas
                bankAddress,                // to
                amount,                     // value
                0x00,                       // inOffset (无调用数据)
                0x00,                       // inSize
                0x00,                       // outOffset
                0x00                        // outSize
            )
        }
        
        emit CallExecuted(bankAddress, success, "");
        return success;
    }
    
    // 调用 getBalance 函数（视图函数）
    function callGetBalance(address bankAddress, address user) public returns (uint256) {
        bytes4 getBalanceSelector = bytes4(keccak256("getBalance(address)"));
        uint256 result;
        
        assembly {
            // 在内存中准备调用数据: getBalance(address)
            mstore(0x00, getBalanceSelector)   // 函数选择器
            mstore(0x04, user)                 // 参数: address
            
            // 执行 CALL
            let success := call(
                gas(),                      // gas
                bankAddress,                // to
                0,                          // value (不发送 ETH)
                0x00,                       // inOffset
                0x24,                       // inSize (4 + 32 = 36 bytes)
                0x00,                       // outOffset
                0x20                        // outSize (期望返回 32 字节)
            )
            
            // 如果调用成功，读取返回值
            if success {
                result := mload(0x00)
            }
        }
        
        return result;
    }
}


/**
 CALL 操作码是以太坊合约间交互的核心机制：

主要特性：

支持 ETH 转账和合约调用

可以传递调用数据和接收返回数据

消耗 Gas，成本取决于操作复杂度

返回布尔值表示调用成功与否

关键应用场景：

ETH 转账：向其他地址发送以太币

合约交互：调用其他合约的函数

批量操作：执行多个调用操作

代理模式：实现可升级合约

DeFi 集成：与外部协议交互

最佳实践：

始终检查 CALL 的返回值

合理设置 Gas 限制

使用重入攻击防护

验证目标地址

妥善处理返回数据

考虑使用静态调用进行只读操作
 */