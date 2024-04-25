// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract SimpleOperations {

    /**
     * @notice calculateAverage calculates the average of two numbers
     * @param a the first number
     * @param b the second number
     * @return the average of the two numbers
     */
    function calculateAverage(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 c = (a + b) / 2;
        return c;
    }

    /**
     * @notice getBit returns the bit at the given position
     * @param num the number to get the bit from
     * @param position the position of the bit to get
     * @return the bit at the given position
     */
    function getBit(uint256 num, uint256 position) public pure returns (uint8) {
        // Calculate the number of bits required for the binary representation
        uint256 numBits = 0;
        uint256 tempNum = num;
        while (tempNum > 0) {
            tempNum >>= 1;
            numBits++;
        }
        
        // Convert the decimal number to binary and store it in an array
        uint8[] memory binary = new uint8[](numBits);
        for (uint256 i = 0; i < numBits; i++) {
            binary[numBits - i - 1] = uint8((num >> i) & 1);
        }
        
        // Reverse the binary array
        for (uint256 i = 0; i < numBits / 2; i++) {
            uint8 temp = binary[i];
            binary[i] = binary[numBits - i - 1];
            binary[numBits - i - 1] = temp;
        }
        
        // Return the binary digit at the specified position (adjusted to start from 1)
        require(position >= 1 && position <= numBits, "Position exceeds bit range");
        return binary[position - 1]; // Adjust position to start from 1
    }

    /**
     * @notice sendEth sends ETH to the given address
     * @param to the address to send ETH to
     */
    function sendEth(address to) public payable {
        require(msg.sender != to, "Cannot send Ether to yourself");
        (bool sent,) = to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
