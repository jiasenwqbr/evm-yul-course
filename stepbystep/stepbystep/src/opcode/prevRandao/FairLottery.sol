// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract FairLottery {
    struct Lottery {
        uint256 id;
        string name;
        uint256 ticketPrice;
        uint256 prizePool;
        uint256 endBlock;
        bool ended;
        address[] participants;
        address winner;
        uint256 winningNumber;
    }
    
    mapping(uint256 => Lottery) public lotteries;
    mapping(uint256 => mapping(address => uint256)) public ticketsBought;
    
    uint256 public lotteryCounter;
    address public owner;
    
    event LotteryCreated(uint256 indexed lotteryId, string name, uint256 ticketPrice, uint256 endBlock);
    event TicketPurchased(uint256 indexed lotteryId, address participant, uint256 ticketCount);
    event LotteryEnded(uint256 indexed lotteryId, address winner, uint256 prize);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    modifier lotteryActive(uint256 lotteryId) {
        require(!lotteries[lotteryId].ended, "Lottery ended");
        require(block.number < lotteries[lotteryId].endBlock, "Lottery period over");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * 创建新彩票
     */
    function createLottery(
        string memory name,
        uint256 ticketPrice,
        uint256 durationBlocks
    ) public onlyOwner returns (uint256) {
        require(ticketPrice > 0, "Ticket price must be positive");
        require(durationBlocks > 0, "Duration must be positive");
        
        uint256 lotteryId = lotteryCounter++;
        uint256 endBlock = block.number + durationBlocks;
        
        lotteries[lotteryId] = Lottery({
            id: lotteryId,
            name: name,
            ticketPrice: ticketPrice,
            prizePool: 0,
            endBlock: endBlock,
            ended: false,
            participants: new address[](0),
            winner: address(0),
            winningNumber: 0
        });
        
        emit LotteryCreated(lotteryId, name, ticketPrice, endBlock);
        return lotteryId;
    }
    
    /**
     * 购买彩票
     */
    function buyTickets(uint256 lotteryId, uint256 ticketCount) public payable lotteryActive(lotteryId) {
        require(ticketCount > 0, "Must buy at least one ticket");
        
        Lottery storage lottery = lotteries[lotteryId];
        uint256 totalCost = lottery.ticketPrice * ticketCount;
        require(msg.value == totalCost, "Incorrect ETH amount");
        
        // 记录参与者
        if (ticketsBought[lotteryId][msg.sender] == 0) {
            lottery.participants.push(msg.sender);
        }
        
        ticketsBought[lotteryId][msg.sender] += ticketCount;
        lottery.prizePool += totalCost;
        
        emit TicketPurchased(lotteryId, msg.sender, ticketCount);
    }
    
    /**
     * 结束彩票并选择获胜者
     */
    function endLottery(uint256 lotteryId) public onlyOwner {
        Lottery storage lottery = lotteries[lotteryId];
        require(!lottery.ended, "Lottery already ended");
        require(block.number >= lottery.endBlock, "Lottery period not over");
        require(lottery.participants.length > 0, "No participants");
        
        // 使用 PREVRANDAO 生成随机数选择获胜者
        uint256 random = generateLotteryRandom(lotteryId);
        uint256 winnerIndex = random % lottery.participants.length;
        lottery.winner = lottery.participants[winnerIndex];
        lottery.winningNumber = random;
        lottery.ended = true;
        
        // 发放奖金
        uint256 prize = lottery.prizePool;
        if (prize > 0) {
            payable(lottery.winner).transfer(prize);
        }
        
        emit LotteryEnded(lotteryId, lottery.winner, prize);
    }
    
    /**
     * 生成彩票随机数（使用多个随机源确保公平）
     */
    function generateLotteryRandom(uint256 lotteryId) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            block.prevrandao,                      // 主要随机源
            blockhash(lotteryId),                  // 彩票ID相关的区块哈希
            block.timestamp,                       // 时间戳
            lotteries[lotteryId].prizePool,        // 奖池金额
            lotteries[lotteryId].participants.length // 参与者数量
        )));
    }
    
    /**
     * 获取彩票详情
     */
    function getLotteryInfo(uint256 lotteryId) public view returns (
        string memory name,
        uint256 ticketPrice,
        uint256 prizePool,
        uint256 endBlock,
        uint256 blocksRemaining,
        uint256 participantCount,
        bool ended,
        address winner
    ) {
        Lottery storage lottery = lotteries[lotteryId];
        name = lottery.name;
        ticketPrice = lottery.ticketPrice;
        prizePool = lottery.prizePool;
        endBlock = lottery.endBlock;
        blocksRemaining = endBlock > block.number ? endBlock - block.number : 0;
        participantCount = lottery.participants.length;
        ended = lottery.ended;
        winner = lottery.winner;
        
        return (name, ticketPrice, prizePool, endBlock, blocksRemaining, participantCount, ended, winner);
    }
    
    /**
     * 获取用户在该彩票中的票数
     */
    function getUserTickets(uint256 lotteryId, address user) public view returns (uint256) {
        return ticketsBought[lotteryId][user];
    }
}