// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/opcode/sub/SubExample.sol";

contract SubExampleTest is Test {
    SubExample subExample;
    function setUp() public {
        subExample = new SubExample();
    }

    function testSub() public view {
        assertEq(subExample.sub(10,8),2);
        console.log("subExample.subUnchecked(10,100):",subExample.subUnchecked(10,100));
        assertEq(subExample.subUnchecked(10,100),UINT256_MAX-89);
    }
    
}