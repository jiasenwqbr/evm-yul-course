// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract SstoreBasic {
    uint256 public value1;
    uint256 public value2;
    
    function basicSstore() public {
        uint256 gasStart = gasleft();
        
        assembly {
            // 首次写入：零 → 非零 (20,000 gas + 2,100 冷访问)
            sstore(0, 0x1234567890ABCDEF)
            
            // 修改写入：非零 → 非零 (100 gas 热访问)
            sstore(0, 0xFFFFFFFFFFFFFFFF)
            
            // 另一个存储槽的首次写入 (20,000 gas + 2,100 冷访问)
            sstore(1, 0x1111111111111111)
        }
        
        uint256 gasUsed = gasStart - gasleft();
        // gasUsed 大约为: 20,000 + 100 + 20,000 + 2,100 + 2,100 = 44,300 gas
    }
    
    function demonstrateRefund() public {
        assembly {
            // 先设置一个值 (20,000 + 2,100 gas)
            sstore(2, 0x2222222222222222)
            
            // 然后删除它：非零 → 零 (获得 15,000 gas 退款)
            sstore(2, 0)
            // 净成本: 2,900 gas - 15,000 退款 = -12,100 gas
        }
    }
}