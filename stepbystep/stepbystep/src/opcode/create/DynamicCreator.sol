// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// contract DynamicCreator {
//     // 简单的计数器合约字节码
//    bytes public constant COUNTER_BYTECODE = hex"6080604052348015600e575f80fd5b5060c28061001b5f395ff3fe6080604052348015600e575f80fd5b50600436106030575f3560e01c806306661abd146034578063b6b55f2514604e575b5f80fd5b603a6067565b604051604591906081565b60405180910390f35b606560048036038101906060919060a5565b606d565b005b5f5481565b805f8190555050565b5f819050919050565b607b81606b565b82525050565b5f60208201905060925f8301846074565b92915050565b5f80fd5b606381606b565b8114608c575f80fd5b50565b5f81359050609b816098565b92915050565b5f6020828403121560b45760b36094565b5b5f60bf84828501608f565b9150509291505056fea2646970667358221220123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef64736f6c63430008180033";

//     function createCounter() public returns (address) {
//         address newCounter;
        
//         assembly {
//             // 直接从常量字节码创建
//             let codePtr := add(COUNTER_BYTECODE, 0x20)
//             let codeLength := mload(COUNTER_BYTECODE)
            
//             newCounter := create(0, codePtr, codeLength)
//         }
        
//         return newCounter;
//     }
    
//     // 创建带自定义初始值的计数器
//     function createCounterWithInitialValue(uint256 initialValue) public returns (address) {
//         // 计数器合约的字节码（简化版本）
//         bytes memory bytecode = hex"608060405234801561000f575f80fd5b5060df8061001c5f395ff3fe6080604052348015600e575f80fd5b50600436106030575f3560e01c806306661abd146034578063b6b55f2514604e575b5f80fd5b603a6067565b604051604591906081565b60405180910390f35b606560048036038101906060919060a5565b606d565b005b5f5481565b805f8190555050565b5f819050919050565b607b81606b565b82525050565b5f60208201905060925f8301846074565b92915050565b5f80fd5b606381606b565b8114608c575f80fd5b50565b5f81359050609b816098565b92915050565b5f6020828403121560b45760b36094565b5b5f60bf84828501608f565b9150509291505056fea2646970667358221220cafecafecafecafecafecafecafecafecafecafecafecafecafecafecafecafe64736f6c63430008180033";
        
//         // 修改字节码中的初始值（在实际应用中需要更复杂的字节码操作）
//         // 这里只是演示概念
        
//         address newCounter;
//         assembly {
//             let codePtr := add(bytecode, 0x20)
//             let codeLength := mload(bytecode)
            
//             newCounter := create(0, codePtr, codeLength)
//         }
        
//         return newCounter;
//     }
// }