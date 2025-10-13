// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AdvancedAssemblyCaller {
     /**
     * 使用纯汇编调用一个函数并处理其 ABI 编码的返回值。
     * 假设我们调用一个返回 (uint256, string) 的函数。
     */
    function complexCall(address _contract) public view returns (uint256 num, string memory str) {
        bytes4 selector = bytes4(keccak256("getComplexData()"));
        
        assembly {
            // 分配内存用于函数调用数据
            let ptr := mload(0x40)
            mstore(ptr, selector) // 将函数选择器放入内存

            // 进行调用
            let success := staticcall(
                gas(),           // 传递所有可用 gas
                _contract,       // 目标地址
                ptr,             // 输入数据指针
                0x04,            // 输入数据长度 (4 bytes for selector)
                0,               // 输出数据位置 (0 因为我们用 returndatacopy)
                0                // 输出数据长度
            )

            // 检查调用是否成功
            if iszero(success) {
                revert(0, 0)
            }

            // --- 现在处理返回值 ---
            // 返回值是 ABI 编码的：[
            //   0x00: uint256 (32 bytes)
            //   0x20: string offset (32 bytes, 指向字符串数据的位置)
            //   0x40: string length (32 bytes)
            //   0x60: string data (... bytes)
            // ]

            // 1. 获取整个返回数据的大小
            let totalSize := returndatasize()
            // 对于 (uint256, string)，最小大小应该是 0x60 + 字符串长度
            if lt(totalSize, 0x60) {
                revert(0, 0) // 数据太短，不合法
            }

            // 2. 将返回数据复制到内存中以便处理
            returndatacopy(0, 0, totalSize)

            // 3. 解析 uint256 (位于内存 0x00)
            num := mload(0)

            // 4. 解析 string
            // 字符串的偏移量存储在内存 0x20
            let strOffset := mload(0x20)
            // 字符串长度存储在 (0x20 + strOffset) = 0x40
            let strLength := mload(0x40)
            // 字符串数据从 0x60 开始

            // 为返回的 string 分配内存
            str := mload(0x40) // 获取当前空闲内存指针
            mstore(str, strLength) // 存储字符串长度
            // 复制字符串数据
            returndatacopy(add(str, 0x20), 0x60, strLength)
            // 更新空闲内存指针
            mstore(0x40, add(add(str, 0x20), strLength))
        }
    }
}