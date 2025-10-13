// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ErrorHandler {
     /**
     * 调用一个可能会 revert 的合约，并捕获其错误信息。
     */
    function callWithRevertHandler(address _callee, bytes memory _data) public {
        (bool success, bytes memory returnData) = _callee.call(_data);

        if (!success) {
            // 调用失败，returnData 包含了 revert 信息
            uint256 size = returnData.length; // 这里底层就是用的 returndatasize/returndatacopy

            // 检查是否有 revert 信息
            if (size > 0) {
                // 你可以在这里解析错误信息
                // 假设错误信息是一个 string
                assembly {
                    // returnData 的格式已经是 [长度, 数据]
                    let ptr := add(returnData, 0x20)
                    // 我们可以用 revert 将错误信息原样抛出
                    revert(ptr, size)
                }
            } else {
                // 没有错误信息，抛出默认错误
                revert("Call failed without reason");
            }
        }
        // 调用成功，处理 returnData...
    }

    /**
     * 一个模拟会 revert 的合约，用于测试。
     */
    function testRevert() public pure {
        revert("This is a custom error message from the callee!");
    }
}