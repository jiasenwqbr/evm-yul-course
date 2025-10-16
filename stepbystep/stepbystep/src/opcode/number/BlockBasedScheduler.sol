// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BlockBasedScheduler {
    struct ScheduledTask {
        address executor;
        uint256 targetBlock;
        bytes callData;
        bool executed;
        string description;
    }
    
    mapping(uint256 => ScheduledTask) public tasks;
    uint256 public taskCounter;
    
    event TaskScheduled(uint256 indexed taskId, address executor, uint256 targetBlock, string description);
    event TaskExecuted(uint256 indexed taskId, address executor, uint256 actualBlock);
    
    /**
     * 安排一个在特定区块执行的任务
     */
    function scheduleTask(
        uint256 targetBlock,
        bytes memory callData,
        string memory description
    ) public returns (uint256) {
        require(targetBlock > block.number, "Target block must be in future");
        
        uint256 taskId = taskCounter++;
        tasks[taskId] = ScheduledTask({
            executor: msg.sender,
            targetBlock: targetBlock,
            callData: callData,
            executed: false,
            description: description
        });
        
        emit TaskScheduled(taskId, msg.sender, targetBlock, description);
        return taskId;
    }
    
    /**
     * 执行到期的任务
     */
    function executeTask(uint256 taskId) public returns (bool) {
        ScheduledTask storage task = tasks[taskId];
        require(!task.executed, "Task already executed");
        require(block.number >= task.targetBlock, "Target block not reached");
        require(msg.sender == task.executor, "Only executor can execute");
        
        // 执行任务（这里只是模拟）
        // 在实际应用中，可能会调用其他合约
        task.executed = true;
        
        emit TaskExecuted(taskId, msg.sender, block.number);
        return true;
    }
    
    /**
     * 批量检查任务状态
     */
    function checkTasks(uint256[] memory taskIds) public view returns (
        bool[] memory canExecute,
        uint256[] memory blocksRemaining
    ) {
        canExecute = new bool[](taskIds.length);
        blocksRemaining = new uint256[](taskIds.length);
        
        for (uint256 i = 0; i < taskIds.length; i++) {
            ScheduledTask storage task = tasks[taskIds[i]];
            
            if (task.executed) {
                canExecute[i] = false;
                blocksRemaining[i] = 0;
            } else {
                canExecute[i] = block.number >= task.targetBlock;
                if (task.targetBlock > block.number) {
                    blocksRemaining[i] = task.targetBlock - block.number;
                } else {
                    blocksRemaining[i] = 0;
                }
            }
        }
        
        return (canExecute, blocksRemaining);
    }
    
    /**
     * 获取即将执行的任务
     */
    function getUpcomingTasks(uint256 maxCount) public view returns (ScheduledTask[] memory) {
        uint256 count = 0;
        
        // 首先计算符合条件的任务数量
        for (uint256 i = 0; i < taskCounter; i++) {
            if (!tasks[i].executed && tasks[i].targetBlock >= block.number) {
                count++;
                if (count >= maxCount) break;
            }
        }
        
        // 收集任务
        ScheduledTask[] memory upcoming = new ScheduledTask[](count);
        uint256 index = 0;
        
        for (uint256 i = 0; i < taskCounter && index < count; i++) {
            if (!tasks[i].executed && tasks[i].targetBlock >= block.number) {
                upcoming[index] = tasks[i];
                index++;
            }
        }
        
        return upcoming;
    }
}