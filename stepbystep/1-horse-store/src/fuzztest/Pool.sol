// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Simple UniswapV2-like Pool with fee and withdraw examples
contract Pool {
    uint public reserve0;
    uint public reserve1;

    // fee in basis points relative to FEE_DEN
    uint public feeBP;
    uint public constant FEE_DEN = 10000; // 10000 -> 100%

    // simple ledger for deposited ETH (for withdraw demo)
    mapping(address => uint) public balances;

    event Sync(uint reserve0, uint reserve1);
    event Deposit(address indexed who, uint amount);
    event Withdraw(address indexed who, uint amount);

    constructor(uint _feeBP) {
        require(_feeBP <= 5000, "fee too high");
        feeBP = _feeBP;
    }

    /// @notice initialize reserves (only allowed once)
    function initialize(uint _r0, uint _r1) external {
        require(reserve0 == 0 && reserve1 == 0, "Already initialized");
        require(_r0 > 0 && _r1 > 0, "Invalid reserves");
        reserve0 = _r0;
        reserve1 = _r1;
        emit Sync(reserve0, reserve1);
    }

    /// @notice deposit ETH for withdraw demo (not related to pool reserves)
    function deposit() external payable {
        require(msg.value > 0, "zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Vulnerable withdraw: transfer before updating balance (reentrancy possible)
    function vulnerableWithdraw(uint amount) external {
        require(balances[msg.sender] >= amount, "insufficient");
        // send first (vuln)
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
        // then update
        unchecked { balances[msg.sender] -= amount; }
        emit Withdraw(msg.sender, amount);
    }

    /// @notice Safe withdraw: update before transfer (CEI)
    function safeWithdraw(uint amount) external {
        require(balances[msg.sender] >= amount, "insufficient");
        balances[msg.sender] -= amount;
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
        emit Withdraw(msg.sender, amount);
    }

    /// @notice Swap using constant product with fee
    /// amountIn: input token amount (atomic units)
    /// zeroForOne: true if swap token0 -> token1
    function swap(uint amountIn, bool zeroForOne) external returns (uint amountOut) {
        require(amountIn > 0, "Zero input");
        // apply fee: amountInWithFee = amountIn * (1 - fee)
        uint amountInWithFee = amountIn * (FEE_DEN - feeBP) / FEE_DEN;

        if (zeroForOne) {
            uint newReserve0 = reserve0 + amountInWithFee;
            // amountOut = reserve1 - (reserve0 * reserve1) / newReserve0
            amountOut = reserve1 - (reserve0 * reserve1) / newReserve0;
            require(amountOut < reserve1, "Bad math");
            reserve0 = reserve0 + amountIn; // note: reserve increases by full amountIn (for simplicity)
            reserve1 = reserve1 - amountOut;
        } else {
            uint newReserve1 = reserve1 + amountInWithFee;
            amountOut = reserve0 - (reserve0 * reserve1) / newReserve1;
            require(amountOut < reserve0, "Bad math");
            reserve1 = reserve1 + amountIn;
            reserve0 = reserve0 - amountOut;
        }

        emit Sync(reserve0, reserve1);
    }

    /// helper: compute theoretical amountOut given fee (pure)
    function getAmountOutView(uint amountIn, bool zeroForOne) external view returns (uint amountOut) {
        if (amountIn == 0) return 0;
        uint amountInWithFee = amountIn * (FEE_DEN - feeBP) / FEE_DEN;
        if (zeroForOne) {
            uint newReserve0 = reserve0 + amountInWithFee;
            amountOut = reserve1 - (reserve0 * reserve1) / newReserve0;
        } else {
            uint newReserve1 = reserve1 + amountInWithFee;
            amountOut = reserve0 - (reserve0 * reserve1) / newReserve1;
        }
    }

    // receive fallback to accept ETH (for withdraw demo)
    receive() external payable {}
}
