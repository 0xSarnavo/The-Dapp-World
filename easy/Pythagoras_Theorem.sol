// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RightAngledTriangle {
    //To check if a triangle with side lenghts a,b,c is a right angled triangle
    function check(uint a, uint b, uint c) public pure returns (bool) {
        uint x=a*a;
        uint y=b*b;
        uint z=c*c;

        if(x==0 || y==0 || z==0 )
        return false;
        else if(z==(x+y) || x==(y+z) || y==(x+z))
        return true;
        else 
        return false;
    }
}
