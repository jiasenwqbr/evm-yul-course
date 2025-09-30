// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedKeccakUsage {
    // 使用 keccak256 创建存储槽位置
    mapping(bytes32 => uint256) public balances;
    mapping(address => mapping(bytes32 => bool)) public userApprovals;
    
    // 使用存储槽计算
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");
    bytes32 public constant USER_ROLE = keccak256("USER");
    
    // 创建确定性地址 (CREATE2 的前身)
    function computeAddress(address deployer, bytes32 salt, bytes32 initCodeHash) 
        public 
        pure 
        returns (address) 
    {
        bytes32 hash;
        assembly {
            // 内存布局用于CREATE2计算
            let ptr := mload(0x40) // 获取自由内存指针
            
            // 构建哈希数据: 0xff + deployer + salt + initCodeHash
            mstore8(ptr, 0xff)
            mstore(add(ptr, 1), deployer)
            mstore(add(ptr, 21), salt)
            mstore(add(ptr, 53), initCodeHash)
            
            // 计算哈希
            hash := keccak256(ptr, 85) // 1 + 20 + 32 + 32 = 85 bytes
            
            // 转换为地址 (取后20字节)
            mstore(ptr, hash)
            hash := mload(ptr) // 现在hash包含地址格式
        }
        return address(uint160(uint256(hash)));
    }
    
    // Merkle树证明验证
    function verifyMerkleProof(
        bytes32 leaf,
        bytes32 root,
        bytes32[] memory proof
    ) public pure returns (bool) {
        bytes32 computedHash = leaf;
        
        assembly {
            // 遍历证明路径
            let proofLength := mload(proof)
            let proofPtr := add(proof, 0x20) // 指向第一个证明元素
            
            for { let i := 0 } lt(i, proofLength) { i := add(i, 1) } {
                let proofElement := mload(proofPtr)
                
                // 内存布局用于哈希计算
                mstore(0x00, computedHash)
                mstore(0x20, proofElement)
                
                // 决定顺序：computedHash < proofElement ?
                if lt(computedHash, proofElement) {
                    computedHash := keccak256(0x00, 0x40)
                } {
                    mstore(0x00, proofElement)
                    mstore(0x20, computedHash)
                    computedHash := keccak256(0x00, 0x40)
                }
                
                proofPtr := add(proofPtr, 0x20) // 移动到下一个证明元素
            }
        }
        
        return computedHash == root;
    }
    
    // 使用 keccak256 进行角色验证
    function hasRole(bytes32 role, address account) public view returns (bool) {
        bytes32 slot = keccak256(abi.encode(role, account));
        bool storedValue;
        assembly {
            storedValue := sload(slot)
        }
        return storedValue;
    }
}