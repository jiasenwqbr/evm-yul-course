// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract GasOptimizedBatchProcessor {
    struct BatchJob {
        address[] targets;
        bytes[] callData;
        bool[] executed;
        uint256 gasReserve;
    }
    
    mapping(uint256 => BatchJob) public batchJobs;
    uint256 public jobCounter;
    
    event BatchJobCreated(uint256 indexed jobId, uint256 targetCount, uint256 gasReserve);
    event BatchItemExecuted(uint256 indexed jobId, uint256 itemIndex, bool success);
    event BatchCompleted(uint256 indexed jobId, uint256 successfulExecutions);
    
    /**
     * 创建批量处理任务
     */
    function createBatchJob(
        address[] memory targets,
        bytes[] memory callData,
        uint256 gasReserve
    ) public returns (uint256) {
        require(targets.length == callData.length, "Arrays length mismatch");
        require(targets.length > 0, "No targets provided");
        
        uint256 jobId = jobCounter++;
        batchJobs[jobId] = BatchJob({
            targets: targets,
            callData: callData,
            executed: new bool[](targets.length),
            gasReserve: gasReserve
        });
        
        emit BatchJobCreated(jobId, targets.length, gasReserve);
        return jobId;
    }
    
    /**
     * 执行批量任务（带 Gas 优化）
     */
    function executeBatch(uint256 jobId, uint256 maxItems) public returns (uint256 executedCount) {
        BatchJob storage job = batchJobs[jobId];
        require(job.targets.length > 0, "Job does not exist");
        
        uint256 startGas = gasleft();
        uint256 blockGasLimit = block.gaslimit;
        uint256 safetyMargin = job.gasReserve;
        
        executedCount = 0;
        
        for (uint256 i = 0; i < job.targets.length && executedCount < maxItems; i++) {
            if (job.executed[i]) {
                continue; // 跳过已执行的项
            }
            
            // 检查剩余 Gas 是否足够（保留安全边界）
            uint256 estimatedItemGas = estimateGasForCall(job.callData[i]);
            if (gasleft() < estimatedItemGas + safetyMargin) {
                break; // Gas 不足，停止执行
            }
            
            // 检查是否会超过区块 Gas 限制
            if (startGas - gasleft() + estimatedItemGas > blockGasLimit - safetyMargin) {
                break; // 可能超过区块限制，停止执行
            }
            
            // 执行调用
            (bool success, ) = job.targets[i].call(job.callData[i]);
            job.executed[i] = true;
            executedCount++;
            
            emit BatchItemExecuted(jobId, i, success);
        }
        
        if (isBatchComplete(jobId)) {
            emit BatchCompleted(jobId, getSuccessfulCount(jobId));
        }
        
        return executedCount;
    }
    
    /**
     * 估算调用所需的 Gas（简化版本）
     */
    function estimateGasForCall(bytes memory callData) public pure returns (uint256) {
        // 这是一个简化的估算，实际应用中可能需要更复杂的逻辑
        // 基础 Gas + 数据长度相关 Gas
        return 21000 + (callData.length * 16);
    }
    
    /**
     * 获取推荐的批量大小
     */
    function getRecommendedBatchSize(uint256 estimatedGasPerItem) public view returns (uint256) {
        uint256 blockGasLimit = block.gaslimit;
        uint256 availableGas = blockGasLimit * 80 / 100; // 使用 80% 的区块限制
        
        // 保留基础 Gas 用于合约操作
        uint256 baseOverhead = 50000;
        if (availableGas < baseOverhead + estimatedGasPerItem) {
            return 0;
        }
        
        return (availableGas - baseOverhead) / estimatedGasPerItem;
    }
    
    /**
     * 检查批量任务是否完成
     */
    function isBatchComplete(uint256 jobId) public view returns (bool) {
        BatchJob storage job = batchJobs[jobId];
        for (uint256 i = 0; i < job.executed.length; i++) {
            if (!job.executed[i]) {
                return false;
            }
        }
        return true;
    }
    
    /**
     * 获取成功执行的数量
     */
    function getSuccessfulCount(uint256 jobId) public view returns (uint256) {
        BatchJob storage job = batchJobs[jobId];
        uint256 count = 0;
        for (uint256 i = 0; i < job.executed.length; i++) {
            if (job.executed[i]) {
                count++;
            }
        }
        return count;
    }
    
    /**
     * 获取批量任务状态
     */
    function getBatchStatus(uint256 jobId) public view returns (
        uint256 totalItems,
        uint256 executedItems,
        uint256 remainingItems,
        bool completed
    ) {
        BatchJob storage job = batchJobs[jobId];
        totalItems = job.targets.length;
        executedItems = getSuccessfulCount(jobId);
        remainingItems = totalItems - executedItems;
        completed = isBatchComplete(jobId);
        
        return (totalItems, executedItems, remainingItems, completed);
    }
}