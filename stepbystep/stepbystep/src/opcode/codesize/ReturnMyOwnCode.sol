// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ReturnMyOwnCode {
    // 此函数返回当前合约的完整字节码
    function getMyCode() public pure returns (bytes memory o_code) {
        assembly {
            // 1. 获取代码大小
            let size := codesize()
            
            // 2. 为返回数据分配内存空间
            // `o_code` 是返回值，它位于内存的“空闲内存指针”位置

            /**
             * mload(0x40) 读取内存位置 0x40 的内容 —— 按约定这里存放的是 free memory pointer（空闲内存指针），即下一段可用内存的起始偏移。
                把这个指针赋给 o_code，意味着我们将从这里开始构造返回的 bytes 值（bytes 的内存格式是：先 32 字节长度，然后紧接着数据）。
                说明：编译器会把返回变量 o_code（bytes memory）视为一个内存指针，函数返回时 Solidity 会根据 o_code 指向的内存区域把返回数据构造出来。
             */
            o_code := mload(0x40)
            
            // 3. 更新空闲内存指针（原有值 + 字节码长度 + bytes32 用于存储长度前缀的空间）
            mstore(0x40, 
                add(o_code, 
                    and(
                        add(
                            add(size, 0x20), 
                            0x1f
                        ), 
                        not(0x1f)
                    )
                )
            )
            
            // 4. 将字节码长度存储为 bytes 数组的长度前缀
            mstore(o_code, size)
            
            // 5. 执行 CODECOPY，将整个合约代码复制到内存中
            // 参数: codecopy(dest, src, length)
            // - dest: 内存目标地址 (o_code + 0x20，跳过32字节的长度前缀)
            // - src: 代码中的偏移量 (0，从头开始)
            // - length: 要复制的字节数 (size)
            codecopy(add(o_code, 0x20), 0, size)
        }
    }
}