// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 库合约 - 包含可重用的逻辑
contract MathLibrary {
    // 注意：库合约不应该有状态变量！
    
    function square(uint256 x) public pure returns (uint256) {
        return x * x;
    }
    
    function cube(uint256 x) public pure returns (uint256) {
        return x * x * x;
    }
    
    function sqrt(uint256 x) public pure returns (uint256) {
        if (x == 0) return 0;
        uint256 z = (x + 1) / 2;
        uint256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
}

// 使用 DELEGATECALL 调用库合约
contract LibraryUser {
    address public mathLibrary;
    
    event CalculationPerformed(string operation, uint256 input, uint256 result);
    
    constructor(address _mathLibrary) {
        mathLibrary = _mathLibrary;
    }
    
    // 使用 DELEGATECALL 调用库函数
    function calculateSquare(uint256 x) public returns (uint256) {
        bytes memory callData = abi.encodeWithSignature("square(uint256)", x);
        uint256 result;
        
        assembly {
            let success := delegatecall(
                gas(),                      // gas
                sload(mathLibrary.slot),    // to (library address)
                add(callData, 0x20),        // inOffset
                mload(callData),            // inSize
                0x00,                       // outOffset
                0x20                        // outSize
            )
            
            // 检查调用是否成功
            if iszero(success) {
                revert(0, 0)
            }
            
            // 读取返回值
            result := mload(0x00)
        }
        
        emit CalculationPerformed("square", x, result);
        return result;
    }
    
    // 使用 Solidity 的高级语法
    function calculateCube(uint256 x) public returns (uint256) {
        (bool success, bytes memory data) = mathLibrary.delegatecall(
            abi.encodeWithSignature("cube(uint256)", x)
        );
        
        require(success, "Delegatecall failed");
        
        uint256 result = abi.decode(data, (uint256));
        emit CalculationPerformed("cube", x, result);
        return result;
    }
    
    // 批量计算
    function batchCalculate(uint256[] memory inputs) public returns (uint256[] memory) {
        uint256[] memory results = new uint256[](inputs.length);
        
        for (uint256 i = 0; i < inputs.length; i++) {
            bytes memory callData = abi.encodeWithSignature("square(uint256)", inputs[i]);
            
            assembly {
                let success := delegatecall(
                    gas(),
                    sload(mathLibrary.slot),
                    add(callData, 0x20),
                    mload(callData),
                    0x00,
                    0x20
                )
                
                if iszero(success) {
                    revert(0, 0)
                }
                
                // 存储结果
                mstore(add(add(results, 0x20), mul(i, 0x20)), mload(0x00))
            }
        }
        
        return results;
    }
}