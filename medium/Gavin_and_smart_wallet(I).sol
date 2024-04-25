// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SmartWallet {

    //this function allows adding funds to wallet
    function addFunds(uint amount) public {}

    //this function allows spending an amount to the account that has been granted access by Gavin
    function spendFunds(uint amount) public {}

    //this function grants access to an account and can only be accessed by Gavin
    function addAccess(address x) public {}

    //this function revokes access to an account and can only be accessed by Gavin
    function revokeAccess(address x) public {}

    //this function returns the current balance of the wallet
    function viewBalance() public returns(uint) {}

}