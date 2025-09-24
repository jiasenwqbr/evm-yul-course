// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/sub/UnderflowDemo.sol";

contract TestUnderflowDemo is Test {
    UnderflowDemo underflowDemo;
    function setUp() public {
        underflowDemo = new UnderflowDemo();
    }
    function testZeroMinusOne() public view {
        assertEq(underflowDemo.zeroMinusOne(),UINT256_MAX);
    }
}