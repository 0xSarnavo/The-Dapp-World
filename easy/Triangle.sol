// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TriangleInequality {
    //To check if a triangle is possible with lengths a,b and c
    function check(uint a, uint b, uint c) public pure returns (bool) {
        if(a==0||b==0||c==0)
        return false;
        else if (a<b+c && b<a+c && c<a+b)
        return true;
        else return false;
    }
}