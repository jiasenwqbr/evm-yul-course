// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EqOwnerCheck {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev 一个只有合约所有者可以调用的函数。
     */
    function restrictedFunction() public view {
        // 使用内联汇编和 eq 来验证 msg.sender == owner
        assembly {
            // 从calldata中加载msg.sender会比较复杂，这里我们用Solidity的逻辑，但展示汇编实现
            // 从存储槽0加载owner地址
            let storedOwner := sload(0)
            // 比较调用者(caller)和存储的owner
            if iszero(eq(caller(), storedOwner)) {
                // 如果不相等，回滚交易
                revert(0, 0)
            }
        }
        // 如果通过检查，继续执行...
        // 例如： 
        // require(msg.sender == owner, "Not owner"); // 这行代码等价于上面的汇编逻辑
    }
}