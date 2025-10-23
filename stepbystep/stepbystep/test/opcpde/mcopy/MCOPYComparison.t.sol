// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";
import {MCOPYComparison} from "../../../src/opcode/mcopy/MCOPYComparison.sol";

contract MCOPYComparisonTest is Test {
    MCOPYComparison mcopyComparison;

    function setUp() public{
        mcopyComparison = new MCOPYComparison();
    }
    function testCopyMemoryWithMCOPY() public view  {
        bytes  memory data = hex"1234567890ABCDEF1234567890ABCDEF";

        bytes memory result1 = mcopyComparison.copyMemoryTraditional(data);

        bytes memory result2 = mcopyComparison.copyMemoryWithMCOPY(data);

       assertEq(result1,result2);
    }
}


/**
 * 
forge test --gas-report --match-contract "MCOPYComparison" -vvvvv
 */