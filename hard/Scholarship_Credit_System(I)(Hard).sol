// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ScholarshipCreditContract {

    //This function assigns credits of particular category to student getting the scholarship
    function grantScholarship(address studentAddress, uint credits, string category) public {}

    //This function is used to register a new merchant under given category
    function registerMerchantAddress(address merchantAddress, string category) public {}

    //This function is used to deregister an existing merchant
    function deregisterMerchantAddress(address merchantAddress) public {}

    //This function is used to revoke the scholarship of a student
    function revokeScholarship(address studentAddress) public{}

    //Students can use this function to transfer credits only to registered merchants
    function spend(address merchantAddress, uint amount) public {}

    //This function is used to see the available credits assigned.
    function checkBalance(string category) public returns (uint) {}

    //This function is used to see the category under which Merchants are registered
    function showCategory() public returns (string){}
}