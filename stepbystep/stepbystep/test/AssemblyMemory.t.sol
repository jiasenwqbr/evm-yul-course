// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AssemblyMemory} from "../src/AssemblyMemory.sol";

contract AssemblyMemoryTest is Test {
    AssemblyMemory assemblyMemory;
    function setUp() public {
        assemblyMemory = new AssemblyMemory();
    }

    function testReturnHello() public view {
         console.log("return hello:", assemblyMemory.returnHello());
         assertEq(assemblyMemory.returnHello(),"hello");
    }
}