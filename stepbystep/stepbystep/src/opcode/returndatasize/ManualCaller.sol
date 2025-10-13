// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ManualCaller {
    /**
     * 低级调用一个合约的 'name()' 函数，并手动解析返回值。
     * 使用 returndatasize 来检查是否有数据返回。
     */
    function getTokenName(address _token) public view returns (string memory) {
        // 1. 编码函数调用 (name() 的函数选择器)
        bytes4 selector = bytes4(keccak256("name()"));
        (bool success, ) = _token.staticcall(abi.encodeWithSelector(selector));

        // 2. 检查调用是否成功
        require(success, "Low-level call failed");

        // 3. 使用内联汇编处理返回数据
        assembly {
            // 3.1 获取返回数据的长度
            let size := returndatasize()

            // 如果返回数据为空，则直接 revert
            if eq(size, 0) {
                revert(0, 0)
            }

            // 3.2 为返回数据分配内存空间
            // Solidity 中，bytes/string 在内存中的布局是：
            // [0x20]: length (32 bytes)
            // [0x40]: the actual data
            let ptr := mload(0x40) // 获取空闲内存指针

            // 将返回数据复制到 ptr 指向的位置
            // returndatacopy(destOffset, srcOffset, length)
            returndatacopy(ptr, 0, size)

            // 更新内存分配：将长度存储在数据前面
            // 因为我们需要返回一个 string，它的内存表示是 [长度, 数据]
            mstore(ptr, size) // 在 ptr 位置存储长度
            let start := add(ptr, 0x20) // 数据的实际起始位置

            // 3.3 将数据作为 string 返回
            // 返回值的编码是 (offset, length)
            // offset 指向 [长度, 数据] 结构体的开始
            return(ptr, add(size, 0x20))
        }
    }

    /**
     * 一个更简单的版本，只检查返回数据大小而不复制。
     */
    function checkNameReturnSize(address _token) public view returns (uint256 size) {
        bytes4 selector = bytes4(keccak256("name()"));
        (bool success, ) = _token.staticcall(abi.encodeWithSelector(selector));
        require(success, "Call failed");

        assembly {
            size := returndatasize()
        }
        return size;
    }
}