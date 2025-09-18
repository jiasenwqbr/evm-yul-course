// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/AssemblyStorage.sol";

contract TestAssemblyStorage is Test {
    AssemblyStorage assemblyStorage;

    function setUp() public {
        assemblyStorage = new AssemblyStorage();
    }

    function testSetBalAsm() public  {
        address alice = address(0x123);
        assemblyStorage.setBalAsm(alice,40);
        assertEq(assemblyStorage.getBalAsm(alice),40);

    }
}