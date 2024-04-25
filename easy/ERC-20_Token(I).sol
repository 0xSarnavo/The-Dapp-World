// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Implement the ERC-20 smart contract.
contract Token {

    constructor(string name, string symbol) {}

    function mint(address _to, uint256 _amount) {}

    function burn(uint256 amount) onlyNotBlacklisted {}

    function batchMint(address[] calldata _to, uint256[] calldata _amounts) {}

    function publicMint(uint256 amount) {}

    function blacklistUser(address user) {}
}