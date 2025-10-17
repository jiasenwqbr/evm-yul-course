// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";
import {MloadStruct} from "../../../src/opcode/mload/MloadStruct.sol";

contract TestMloadStruct is Test {
   
    MloadStruct mloadStruct;
    function setUp() public{
        mloadStruct = new MloadStruct();
    }

    function testLoadStructFields() public view {
        MloadStruct.MyStruct memory mystruct = MloadStruct.MyStruct({
            a:123456,
            b:7890,
            c:0x727522774ADBD3340E8D420f8d0F45100A3863e1
        });

        (uint256 a, uint256 b, address c) = mloadStruct.loadStructFields(mystruct);

        console.log(c);
        assertEq(a,mystruct.a);
        assertEq(b,mystruct.b);
        assertEq(c,mystruct.c);
    }
}

/**
 
 forge test --gas-report --match-contract "MloadStruct" -vvvvv
 */