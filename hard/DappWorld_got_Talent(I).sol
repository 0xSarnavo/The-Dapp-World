// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DWGotTalent {

    address public owner;

    constructor () {
        owner=msg.sen
    }

    //this function defines the addresses of accounts of judges
    function selectJudges(address[] arrayOfAddresses) public {
        require(msg.send==owner);
    }

    //this function adds the weightage for judges and audiences
    function inputWeightage(uint judgeWeightage, uint audienceWeightage) public {}

    //this function defines the addresses of finalists
    function selectFinalists(address[] arrayOfAddresses) public {}

    //this function strats the voting process
    function startVoting() public {}

    //this function is used to cast the vote 
    function castVote(address finalistAddress) public {}

    //this function ends the process of voting
    function endVoting() public {}

    //this function returns the winner/winners
    function showResult() public returns (address[]) {}

}