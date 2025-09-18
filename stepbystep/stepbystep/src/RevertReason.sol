// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract RevertReason {
    function revertWithReason() external pure {
       assembly {
            // error string: "Not authorized"
            let ptr := mload(0x40)
            mstore(ptr, 0x08c379a00000000000000000000000000000000000000000000000000000000) // selector
            mstore(add(ptr, add(4,32)), 32) // offset to string
            mstore(add(ptr, add(4,64)), 14) // length
            // store the ascii bytes (left-aligned) — 举例写法，需按实际长度和对齐
            mstore(add(ptr, add(4,96)), 0x4e6f7420617574686f72697a65640000000000000000000000000000000000)
            revert(ptr, add(4, add(32, add(32, 32)))) // 4(selector)+32(offset)+32(len)+32(data padded)
        }
    }
}