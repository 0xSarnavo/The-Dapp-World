// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract LCM {
    // Function to calculate the Greatest Common Divisor (GCD) of two numbers
    function gcd(uint a, uint b) internal pure returns (uint) {
        while (b != 0) {
            uint temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    // Function to calculate the Least Common Multiple (LCM) of two numbers
    function lcm(uint a, uint b) public pure returns (uint) {
        require(a > 0 && b > 0, "Both numbers must be greater than zero");
        return (a * b) / gcd(a, b);
    }
}
