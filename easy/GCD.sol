// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract GCDTest {

    //this function calculates the GCD (Greatest Common Divisor)
    function gcd(uint a, uint b) public returns (uint) {
        if (a == 0)
        return b;
    return gcd(b % a, a);
    }

}