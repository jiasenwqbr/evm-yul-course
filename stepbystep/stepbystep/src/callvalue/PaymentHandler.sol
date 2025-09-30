// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentHandler {
    address public owner;
    uint256 public totalReceived;
    uint256 public constant MIN_PAYMENT = 0.01 ether;
    
    event PaymentReceived(address indexed from, uint256 amount, uint256 timestamp);
    event InsufficientPayment(address indexed from, uint256 amount, uint256 required);
    
    constructor() {
        owner = msg.sender;
    }
    
    // 基本支付接收
    receive() external payable {
        uint256 receivedValue;
        assembly {
            receivedValue := callvalue()
        }
        
        totalReceived += receivedValue;
        emit PaymentReceived(msg.sender, receivedValue, block.timestamp);
    }
    
    // 带最小金额检查的支付
    function payWithMinimum() public payable {
        uint256 paymentAmount;
        assembly {
            paymentAmount := callvalue()
        }
        
        require(paymentAmount >= MIN_PAYMENT, "Payment below minimum");
        
        totalReceived += paymentAmount;
        emit PaymentReceived(msg.sender, paymentAmount, block.timestamp);
    }
    
    // 精确金额支付
    function payExactAmount() public payable {
        uint256 exactAmount = 0.1 ether;
        uint256 sentAmount;
        
        assembly {
            sentAmount := callvalue()
        }
        
        require(sentAmount == exactAmount, "Must send exactly 0.1 ETH");
        
        totalReceived += sentAmount;
        emit PaymentReceived(msg.sender, sentAmount, block.timestamp);
    }
    
    // 退款处理：退还多余的资金
    function payWithRefund() public payable {
        uint256 baseAmount = 0.05 ether;
        uint256 sentAmount;
        uint256 refundAmount;
        
        assembly {
            sentAmount := callvalue()
        }
        
        require(sentAmount >= baseAmount, "Insufficient payment");
        
        // 计算退款金额
        if (sentAmount > baseAmount) {
            refundAmount = sentAmount - baseAmount;
            payable(msg.sender).transfer(refundAmount);
        }
        
        totalReceived += baseAmount;
        emit PaymentReceived(msg.sender, baseAmount, block.timestamp);
    }
}