// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 数据提供合约 - 包含各种只读数据
contract DataProvider {
    uint256 public totalSupply = 1000000;
    string public name = "ExampleToken";
    string public symbol = "EXT";
    uint8 public decimals = 18;
    
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;
    
    event Transfer(address indexed from, address indexed to, uint256 value); // 不会被 STATICCALL 触发
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }
    
    function getAllowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }
    
    function getTokenInfo() public view returns (string memory, string memory, uint8, uint256) {
        return (name, symbol, decimals, totalSupply);
    }
    
    // 这个函数会修改状态 - 在 STATICCALL 中会失败
    function setTotalSupply(uint256 newSupply) public {
        totalSupply = newSupply;
    }
}

// STATICCALL 使用示例
contract StaticCallUser {
    address public dataProvider;
    
    event StaticCallPerformed(address target, bytes4 selector, bool success, bytes returnData);
    
    constructor(address _dataProvider) {
        dataProvider = _dataProvider;
    }
    
    // 使用 STATICCALL 查询基本信息
    function getTokenInfoViaStaticCall() public returns (
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 totalSupply
    ) {
        bytes memory callData = abi.encodeWithSignature("getTokenInfo()");
        bytes memory returnData = new bytes(128); // 预分配内存
        
        bool success;
        assembly {
            let dataPtr := add(callData, 0x20)
            let dataSize := mload(callData)
            let returnPtr := add(returnData, 0x20)
            
            success := staticcall(
                gas(),                      // gas
                sload(dataProvider.slot),   // to
                dataPtr,                    // inOffset
                dataSize,                   // inSize
                returnPtr,                  // outOffset
                128                         // outSize
            )
            
            if success {
                let actualSize := returndatasize()
                mstore(returnData, actualSize)
            }
        }
        
        require(success, "Staticcall failed");
        
        // 解码返回数据
        (name, symbol, decimals, totalSupply) = abi.decode(returnData, (string, string, uint8, uint256));
        
        emit StaticCallPerformed(dataProvider, bytes4(keccak256("getTokenInfo()")), success, returnData);
    }
    
    // 使用 STATICCALL 查询余额
    function getBalanceViaStaticCall(address account) public returns (uint256) {
        bytes memory callData = abi.encodeWithSignature("getBalance(address)", account);
        uint256 result;
        
        assembly {
            let dataPtr := add(callData, 0x20)
            let dataSize := mload(callData)
            
            let success := staticcall(
                gas(),
                sload(dataProvider.slot),
                dataPtr,
                dataSize,
                0x00,   // outOffset
                0x20    // outSize
            )
            
            if iszero(success) {
                revert(0, 0)
            }
            
            result := mload(0x00)
        }
        
        return result;
    }
    
    // 使用 Solidity 的高级语法
    function getBalanceViaSolidity(address account) public view returns (uint256) {
        (bool success, bytes memory data) = dataProvider.staticcall(
            abi.encodeWithSignature("getBalance(address)", account)
        );
        
        require(success, "Staticcall failed");
        return abi.decode(data, (uint256));
    }
}
