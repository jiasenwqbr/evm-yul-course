// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CodeInspector {
    /**
     * 获取指定地址的合约代码大小。
     * 通过复制一小段代码来检查其长度，避免直接访问可能不存在的合约。
     */
    function getCodeSize(address _addr) public view returns (uint256 size) {
        assembly {
            // 使用 extcodesize 操作码直接获取大小
            // 这是一个更高效的方法，这里用 extcodecopy 是为了演示
            size := extcodesize(_addr)
        }
        return size;
    }

    /**
     * 使用 EXTCODECOPY 将外部合约的代码复制到内存，并返回前 n 个字节的哈希值。
     * 这是一个更典型的 extcodecopy 使用场景。
     */
    function getCodeHashFragment(address _addr, uint256 _length) public view returns (bytes32 hash) {
        bytes memory code = new bytes(_length);
        
        assembly {
            // 参数：
            // address: _addr
            // memOffset: code 变量的数据位置（跳过长度字段）
            // codeOffset: 从外部合约代码的 0 位置开始
            // length: _length
            extcodecopy(_addr, add(code, 0x20), 0, _length)
        }

        // 计算内存中代码片段的 Keccak-256 哈希
        hash = keccak256(code);
        return hash;
    }

}

/**

1. 什么是 EXTCODECOPY？
EXTCODECOPY 是 "External Code Copy" 的缩写。顾名思义，它的作用是从一个外部合约账户的代码存储区中复制一段字节码，到当前合约的内存中。
操作码值： 0x3c
Gas 消耗： 可变，取决于复制的代码长度和账户访问情况（涉及EIP-2929），基础成本加上内存扩展和字节拷贝的成本。
栈输入： 4 个参数
address: 要复制代码的外部合约的 20 字节地址。
memOffset: 代码字节在当前合约内存中的起始位置（偏移量）。
codeOffset: 从外部合约代码的哪个位置开始复制（偏移量）。
length: 要复制的代码字节数。

2. 工作原理与步骤
当执行 EXTCODECOPY 时，EVM 会进行以下操作：
从栈中弹出参数： 依次弹出 length, codeOffset, memOffset, address。
加载外部代码： EVM 会访问指定 address 的账户，并将其运行时字节码加载到上下文中。如果该地址不是一个合约（例如，是一个外部拥有账户 EOA），则其代码为空。
边界检查与处理：
如果 codeOffset 超出了外部合约代码的长度，则复制到内存的将全是 0。
如果 codeOffset + length 超出了代码长度，则只会复制从 codeOffset 到代码末尾的部分，剩余的内存空间（如果有）会被填充为 0。
内存扩展： 如果需要，EVM 会扩展当前合约的内存以容纳从 memOffset 到 memOffset + length 的数据。这会消耗 Gas。
拷贝数据： 将计算好的外部合约代码字节拷贝到当前合约内存的指定位置。

3. 主要用途
合约验证与分析： 检查另一个合约是否具有特定的字节码（例如，是否是预期的标准合约）。
代理合约/可升级合约： 在代理模式中，逻辑合约可能需要了解其他合约的代码。
链上代码检查器： 构建一个工具合约，用于验证其他合约的代码哈希或检查是否存在某些“函数选择器”。
创建合约工厂： 在创建新合约时，有时需要参考现有合约的代码。

*/