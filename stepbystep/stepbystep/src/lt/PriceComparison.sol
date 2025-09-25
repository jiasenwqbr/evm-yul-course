// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// 去中心化交易所价格比较
contract PriceComparison {
    struct Order {
        uint256 price;
        uint256 amount;
        address trader;
    }
    
    Order[] public buyOrders;
    Order[] public sellOrders;
    
    // 添加买单（价格从高到低排序）
    function addBuyOrder(uint256 price, uint256 amount) public {
        // 找到插入位置（维持降序排列）
        uint256 insertIndex = buyOrders.length;
        
        assembly {
            let ordersLength := sload(buyOrders.slot)
            let i := 0
            
            // 查找第一个价格小于新订单的位置
            for {} lt(i, ordersLength) { i := add(i, 1) } {
                let orderPtr := add(buyOrders.slot, add(1, mul(i, 2))) // 跳过length，每个Order占2slot
                let orderPrice := sload(orderPtr)
                
                // 如果新价格 >= 当前订单价格，继续
                if lt(price, orderPrice) {
                    insertIndex := i
                    break
                }
            }
        }
        
        // 插入订单（实际实现需要移动数组元素）
        // ... 简化实现
        buyOrders.push(Order(price, amount, msg.sender));
    }
    
    // 价格匹配引擎
    function matchOrders() public view returns (uint256 matchedVolume) {
        if (buyOrders.length == 0 || sellOrders.length == 0) return 0;
        
        assembly {
            let buyOrdersPtr := add(buyOrders.slot, 1) // 数组数据开始
            let sellOrdersPtr := add(sellOrders.slot, 1)
            
            let bestBuyPrice := sload(buyOrdersPtr) // 最高买价
            let bestSellPrice := sload(sellOrdersPtr) // 最低卖价
            
            // 检查是否可以匹配：最高买价 >= 最低卖价
            let canMatch := iszero(lt(bestBuyPrice, bestSellPrice))
            
            if canMatch {
                // 执行匹配逻辑...
                matchedVolume := 1
            }
        }
    }
    
    // 检查价格是否在允许范围内
    function isPriceValid(uint256 price, uint256 minPrice, uint256 maxPrice) public pure returns (bool) {
        bool aboveMin;
        bool belowMax;
        
        assembly {
            aboveMin := iszero(lt(price, minPrice))  // price >= minPrice
            belowMax := lt(price, maxPrice)          // price < maxPrice
        }
        
        return aboveMin && belowMax;
    }
}