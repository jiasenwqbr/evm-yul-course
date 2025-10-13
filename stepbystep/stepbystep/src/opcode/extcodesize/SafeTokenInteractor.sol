// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SafeTokenInteractor {
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    // 安全的代币转账函数
    function safeTransfer(address _token, address _to, uint256 _amount) public returns (bool) {
        require(msg.sender == owner, "Not owner");
        
        // 在执行转账前检查目标地址是否为合约
        if (!isContract(_token)) {
            revert("Target is not a contract");
        }
        
        // 检查合约代码大小，防止与未部署或空合约交互
        uint256 codeSize = _token.code.length;
        require(codeSize > 0, "Contract has no code");
        
        // 执行代币转账
        (bool success, ) = _token.call(
            abi.encodeWithSignature("transfer(address,uint256)", _to, _amount)
        );
        
        return success;
    }
    
    // 批量安全转账
    function batchSafeTransfer(
        address _token,
        address[] calldata _recipients,
        uint256[] calldata _amounts
    ) external returns (bool) {
        require(msg.sender == owner, "Not owner");
        require(_recipients.length == _amounts.length, "Arrays length mismatch");
        
        // 预先检查代币合约
        require(isContract(_token), "Token is not a contract");
        require(_token.code.length > 100, "Contract code too small"); // 基本的合理性检查
        
        for (uint256 i = 0; i < _recipients.length; i++) {
            (bool success, ) = _token.call(
                abi.encodeWithSignature("transfer(address,uint256)", _recipients[i], _amounts[i])
            );
            require(success, "Transfer failed");
        }
        
        return true;
    }
    
    // 合约检测辅助函数
    function isContract(address _addr) internal view returns (bool) {
        return _addr.code.length > 0;
    }
}