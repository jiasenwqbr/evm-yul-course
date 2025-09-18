// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyCall {
    function forwardCall(address to, bytes calldata payload) external returns (bytes memory) {
        assembly{
            // 在内存中分配空间
            let ptr := mload(0x40)
            // 把 calldata 中的 payload 拷贝到内存 ptr
            calldatacopy(ptr, payload.offset, payload.length)
             // 执行 call(gas, to, value, inMem, inSize, outMem, outSize)
            let success := call(gas(), to, 0, ptr, payload.length, 0, 0)
            let retSz := returndatasize()
            // 用 free memory 存放返回数据
            let rptr := mload(0x40)
            returndatacopy(rptr, 0, retSz)
            switch success
            case 0 { revert(rptr, retSz) }
            default { return(rptr, retSz) }
        }
    }
}