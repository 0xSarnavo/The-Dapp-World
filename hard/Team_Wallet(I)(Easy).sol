// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TeamWallet {

    //For setting up the wallet
    function setWallet(address[] members, uint256 credtis) public {}

    //For spending amount from the wallet
    function spend(uint256 amount) public {}

    //For approving a transaction request
    function approve(uint256 n) public {}

    //For rejecting a transaction request
    function reject(uint256 n) public {}

    //For checking remaing credits in the wallet
    function credits() public returns (uint256) {}

    //For checking nth transaction status
    function viewTransaction(uint256 n) returns (uint amount,string status){}

}