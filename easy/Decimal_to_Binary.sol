// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ToBinary {

    function toBinary(uint256 n) public pure returns (string memory) {
        require(n < 256, "Enter a number between 0 to 255");

        bytes memory binary = new bytes(8);
        for (uint256 i = 0; i < 8; i++) {
            binary[7 - i] = (n & 1 == 1) ? bytes1(0x31) : bytes1(0x30);
            n >>= 1; 
        }

        return string(binary);
    }

}
