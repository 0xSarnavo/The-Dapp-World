// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RemoveVowels {

    function removeVowels(string memory _input) public pure returns (string memory) {
        bytes memory str = bytes(_input);
        bytes memory output = new bytes(str.length);

        uint j = 0;
        uint i;
        for (i = 0; i < str.length; i++) {
            bytes1 char = str[i];
            if (char != bytes1("A") && char != bytes1("a") &&
                char != bytes1("E") && char != bytes1("e") &&
                char != bytes1("I") && char != bytes1("i") &&
                char != bytes1("O") && char != bytes1("o") &&
                char != bytes1("U") && char != bytes1("u")) {
                output[j++] = char;
            }
        }

        bytes memory resizedOutput = new bytes(j);
        for (i = 0; i < j; i++) {
            resizedOutput[i] = output[i];
        }

        return string(resizedOutput);
    }
}
