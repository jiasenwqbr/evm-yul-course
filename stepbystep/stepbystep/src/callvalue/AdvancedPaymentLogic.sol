// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedPaymentLogic {
    enum ServiceTier { BASIC, PREMIUM, ENTERPRISE }
    
    struct UserAccount {
        uint256 balance;
        ServiceTier tier;
        uint256 lastPayment;
        uint256 totalPaid;
    }
    
    mapping(address => UserAccount) public accounts;
    address public treasury;
    
    uint256 public constant BASIC_PRICE = 0.01 ether;
    uint256 public constant PREMIUM_PRICE = 0.05 ether;
    uint256 public constant ENTERPRISE_PRICE = 0.2 ether;
    
    event TierUpgraded(address indexed user, ServiceTier newTier, uint256 payment);
    event PaymentProcessed(address indexed user, uint256 amount, uint256 newBalance);
    
    constructor(address _treasury) {
        treasury = _treasury;
    }
    
    // 根据支付金额自动选择服务层级
    function purchaseService() public payable {
        uint256 payment;
        assembly {
            payment := callvalue()
        }
        
        ServiceTier selectedTier;
        
        if (payment >= ENTERPRISE_PRICE) {
            selectedTier = ServiceTier.ENTERPRISE;
        } else if (payment >= PREMIUM_PRICE) {
            selectedTier = ServiceTier.PREMIUM;
        } else if (payment >= BASIC_PRICE) {
            selectedTier = ServiceTier.BASIC;
        } else {
            revert("Insufficient payment for any service tier");
        }
        
        // 更新用户账户
        UserAccount storage account = accounts[msg.sender];
        account.balance += payment;
        account.tier = selectedTier;
        account.lastPayment = block.timestamp;
        account.totalPaid += payment;
        
        // 转账到国库
        payable(treasury).transfer(payment);
        
        emit TierUpgraded(msg.sender, selectedTier, payment);
        emit PaymentProcessed(msg.sender, payment, account.balance);
    }
    
    // 多层级支付选项
    function purchaseSpecificTier(ServiceTier tier) public payable {
        uint256 requiredAmount;
        uint256 sentAmount;
        
        assembly {
            sentAmount := callvalue()
        }
        
        if (tier == ServiceTier.BASIC) {
            requiredAmount = BASIC_PRICE;
        } else if (tier == ServiceTier.PREMIUM) {
            requiredAmount = PREMIUM_PRICE;
        } else if (tier == ServiceTier.ENTERPRISE) {
            requiredAmount = ENTERPRISE_PRICE;
        }
        
        require(sentAmount == requiredAmount, "Incorrect payment amount for selected tier");
        
        UserAccount storage account = accounts[msg.sender];
        account.balance += sentAmount;
        account.tier = tier;
        account.lastPayment = block.timestamp;
        account.totalPaid += sentAmount;
        
        payable(treasury).transfer(sentAmount);
        
        emit TierUpgraded(msg.sender, tier, sentAmount);
    }
    
    // 批量支付处理
    function batchPayment(bytes32[] calldata paymentIds) public payable {
        uint256 totalSent;
        assembly {
            totalSent := callvalue()
        }
        
        uint256 expectedAmount = paymentIds.length * BASIC_PRICE;
        require(totalSent == expectedAmount, "Incorrect total payment amount");
        
        UserAccount storage account = accounts[msg.sender];
        account.balance += totalSent;
        account.lastPayment = block.timestamp;
        account.totalPaid += totalSent;
        
        payable(treasury).transfer(totalSent);
        
        emit PaymentProcessed(msg.sender, totalSent, account.balance);
    }
}

