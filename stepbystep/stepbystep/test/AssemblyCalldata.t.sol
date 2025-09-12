// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/AssemblyCalldata.sol";
contract TestAssemblyCalldata is Test {
    AssemblyCalldata assemblyCalldata;
    function setUp() public {
        assemblyCalldata = new AssemblyCalldata();
    }

    function testAddFromCalldata() public  {
        bytes memory callData = abi.encodeWithSignature(
            "addFromCalldata(uint256,uint256)",
            10,
            20
        );
        (bool ok, bytes memory out) = address(assemblyCalldata).call(callData);
        assertTrue(ok);
        uint256 sum = abi.decode(out, (uint256));
        console.log("sum is:",sum);
        assertEq(sum, 30);

        uint256 sum2 = assemblyCalldata.addFromCalldata(100,200);
        assertEq(sum2,300);
    }
}