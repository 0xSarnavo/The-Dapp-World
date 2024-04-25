// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Abacus  {

    int256 private result=0;

    function addInteger(int n) public {
        result=result+n;
    }

    function sumOfIntegers() public view returns(int){
        return result;
    }

}