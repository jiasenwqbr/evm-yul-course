// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GasPriceLogger {
    // 定义一个事件，记录消息、发送者和当时的gasPrice
    event MessageLogged(address indexed sender, string message, uint256 gasPrice, uint256 transactionCost);

    // 记录消息的函数
    function logMessage(string memory _message) public {
        // 获取交易开始后已使用的Gas量
        uint256 startGas = gasleft();

        // 执行一些操作（这里只是触发一个事件，消耗的Gas很少）
        emit MessageLogged(msg.sender, _message, tx.gasprice, 0); // 先不计算成本

        // 计算本次函数调用消耗的Gas
        uint256 gasUsed = startGas - gasleft();
        // 计算用户为这次调用支付的实际费用（Wei）
        // 注意：这只是一个估算，因为整个交易的Gas使用还包括Calldata等成本。
        uint256 transactionCost = gasUsed * tx.gasprice;

        // 为了演示，我们再次触发事件，这次带上成本估算
        // 在实际应用中，你可能会用一个结构体或另一个事件来存储这些信息。
        emit MessageLogged(msg.sender, _message, tx.gasprice, transactionCost);
    }

    // 一个视图函数，方便查看当前的 tx.gasprice
    function getCurrentGasPrice() public view returns (uint256) {
        return tx.gasprice;
    }
}

/**
 
说明：
我们使用 gasleft() 来估算 logMessage 函数本身消耗的 Gas。
transactionCost = gasUsed * tx.gasprice 计算出发送者需要为这次函数调用支付的大概费用（以 Wei 为单位）。
在 Remix 或 Etherscan 上查看事件日志，你可以清晰地看到不同网络条件下（例如 Mainnet 和 Sepolia 测试网）的 gasPrice 差异。

 */