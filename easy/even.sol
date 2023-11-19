// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    function checkEven(int256 num) public pure returns(bool){
        if(num%2==0)
         return true;
        else
         return false;
    }
}