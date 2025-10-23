// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CallBasic {
    event CallResult(address indexed to, uint256 value, bool success);
    
    // 使用 Solidity 的 transfer
    function transferETH(address payable to, uint256 amount) public {
        to.transfer(amount);
    }
    
    // 使用 CALL 操作码进行 ETH 转账
    function transferETHWithCall(address to, uint256 amount) public returns (bool) {
        bool success;
        
        assembly {
            // 准备 CALL 参数
            let gasAmount := gas()        // 使用当前可用的 Gas
            let target := to              // 目标地址
            let ethValue := amount        // 发送的 ETH 数量
            let inOffset := 0             // 输入数据偏移（无调用数据）
            let inSize := 0               // 输入数据大小
            let outOffset := 0            // 输出数据偏移（不需要返回数据）
            let outSize := 0              // 输出数据大小
            
            // 执行 CALL
            success := call(gasAmount, target, ethValue, inOffset, inSize, outOffset, outSize)
        }
        
        emit CallResult(to, amount, success);
        return success;
    }
    
    // 接收 ETH 的函数
    receive() external payable {}
    
    // 检查合约余额
    function getBalance(address addr) public view returns (uint256) {
        return addr.balance;
    }
}