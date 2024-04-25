// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ScholarshipCreditContract {

    //This function assigns credits to student getting the scholarship
    function grantScholarship(address studentAddress, uint credits) public {}

    //This function is used to register a new merchant who can receive credits from students
    function registerMerchantAddress(address merchantAddress) public {}

    //This function is used to deregister an existing merchant
    function deregisterMerchantAddress(address merchantAddress) public {}

    //This function is used to revoke the scholarship of a student
    function revokeScholarship(address studentAddress) public{}

    //Students can use this function to transfer credits only to registered merchants
    function spend(address merchantAddress, uint amount) public {}

    //This function is used to see the available credits assigned.
    function checkBalance() public returns (uint) {}
}