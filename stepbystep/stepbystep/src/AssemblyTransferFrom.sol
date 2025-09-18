// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IERC20 {
    function transferFrom(address, address, uint256) external returns (bool);
}

contract AssemblyTransferFrom {
    // function transferFromLowLevel(address token, address from, address to, uint256 amount)
    function transferFromLowLevel(bytes calldata data) external {
         // data 要与上面的 ABI 对齐（例如 caller 用 abi.encodeWithSelector(...))
         assembly {
            // 跳过 selector: data starts at calldata offset 4
            let token := calldataload(4)  // offse 4..35
            let from := calldataload(36)  // offset 36..67
            let to := calldataload(68)    // offset 68..99
            let amount := calldataload(100)  // offset 100..131

            // 准备 ERC20 transferFrom selector + args 到内存
            let ptr := mload(0x40)
            mstore(ptr, 0x23b872dd00000000000000000000000000000000000000000000000000000000) // transferFrom selector
            mstore(add(ptr,32), from)
            mstore(add(ptr,64), to)
            mstore(add(ptr,96), amount)

            // call token contract
            let success := call(gas(), token, 0, ptr, add(4 , mul(32,3)), ptr, 32)

            // 读取返回
            if iszero(success) {
                // 失败：把 revert reason 返回（复制 returndata）
                let s := returndatasize()
                returndatacopy(ptr, 0, s)
                revert(ptr, s)
            }
            // 可选：检查返回是否为 true
            let returned := mload(ptr) // 如果 token 遵循返回 bool 的习惯
            if iszero(returned) { revert(ptr, 0) }

         }
    }
}