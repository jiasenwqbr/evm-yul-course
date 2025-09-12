// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AssemblyStep0} from "../src/AssemblyStep0.sol";

contract AssemblyStep0Test is Test {
    AssemblyStep0 assemblyStep0;
    function setUp() public {
        assemblyStep0 = new AssemblyStep0();
    }

    function testAdd() public view {
        assertEq(assemblyStep0.addHigh(1,3),4);
        assertEq(assemblyStep0.addAsm(7,8),15);
    }
}