// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ToBinary {
    function toBinary(int256 n) public pure returns (string memory) {
        require(-128 <= n && n <= 127, "Enter a number between -128 and 127");

        if (n >= 0) {
            // Positive number, proceed normally
            return toBinaryUnsigned(uint256(n));
        } else {
            // Negative number, calculate two's complement
            return toBinaryUnsigned(uint256(256 + n)); // Adding 256 keeps the number in the 8-bit range
        }
    }

    function toBinaryUnsigned(uint256 n) internal pure returns (string memory) {
        bytes memory binary = new bytes(8);
        for (uint256 i = 0; i < 8; i++) {
            binary[7 - i] = n % 2 == 1 ? bytes1(0x31) : bytes1(0x30);
            n /= 2;
        }
        return string(binary);
    }
}
