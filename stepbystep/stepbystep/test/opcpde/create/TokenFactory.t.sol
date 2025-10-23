// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Token,TokenFactory} from "../../../src/opcode/create/TokenFactory.sol";
contract TokenFactoryTest is Test {
    TokenFactory tokenFactory;
    function setUp() public {
        tokenFactory = new TokenFactory();
    }

    function testCreateToken() public  {
        address tokenAddress = tokenFactory.createToken("TokenJ","TJ",21000);
        console.log(tokenAddress);
    }
}

/**
 * 
forge test --gas-report --match-contract "TokenFactory" -vvvvv
 */