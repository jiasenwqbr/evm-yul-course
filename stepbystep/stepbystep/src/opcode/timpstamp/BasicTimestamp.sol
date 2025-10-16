// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract BasicTimestamp {
    /**
     * 使用高级 Solidity 语法获取时间戳
     */
    function getTimestampSolidity() public view returns (uint256) {
        return block.timestamp;
    }
    
    /**
     * 使用内联汇编获取时间戳
     */
    function getTimestampAssembly() public view returns (uint256 ts) {
        assembly {
            ts := timestamp()
        }
        return ts;
    }
    
    /**
     * 获取当前时间（转换为更易读的格式）
     */
    function getCurrentTime() public view returns (
        uint256 timestamp1,
        uint256 minutes1,
        uint256 hours1,
        uint256 days1
    ) {
        timestamp1 = block.timestamp;
        minutes1 = timestamp1 / 60;
        hours1 = minutes1 / 60;
        days1 = hours1 / 24;
        
        return (timestamp1, minutes1, hours1, days1);
    }
    
    /**
     * 检查时间戳是否在合理范围内
     */
    function isTimestampReasonable() public view returns (bool) {
        // 简单检查：时间戳应该大于 1600000000 (2020年9月13日)
        return block.timestamp > 1600000000;
    }
}