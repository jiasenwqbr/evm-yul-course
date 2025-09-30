
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SHLExample {
    
    function shiftLeft(uint256 value,uint256 shift) public pure returns (uint256) {
        uint256 result;
        assembly {
            // 从栈中依次取出 value 和 shift，进行左移操作
            // 语法：result := shl(shift, value)
            result := shl(shift,value)
        }
        return result;
    }


    // 一个更具体的例子：计算 2 的 n 次方
    function powerOfTwo(uint256 exponent) public pure returns (uint256) {
        require(exponent < 256, "Exponent too large: would overflow 256 bits");
        uint256 result;
        assembly {
            // 将 1 左移 exponent 位，得到 2^exponent
            // 例如：exponent = 3, 1 << 3 = 8
            result := shl(exponent, 1)
        }
        return result;
    }

}