// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Fibonacci {
    //To find the value of n+1 th Fibonacci number
    function fibonacci(uint n) public pure returns (uint) {
        uint fibo=0;
        uint a=0;
        uint b=1;
        for (uint256 i=2;i<=n;i++)
        {
            fibo=a+b;
            a=b;
            b=fibo;
        }
        return fibo;
    }
}
