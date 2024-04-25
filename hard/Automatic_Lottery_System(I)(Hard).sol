// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LotteryPool {
    
    // For participants to enter the pool
    function enter() public payable {}

    // For participants to withdraw from the pool
    function withdraw() public {}

    // To view participants in current pool
    function viewParticipants() public view returns (address[], uint) {}

    // To view winner of last lottery
    function viewPreviousWinner() public view returns (address) {}

    // To view the amount earned by Gavin
    function viewEarnings() public view returns (uint256) {}

    // To view the amount in the pool
    function viewPoolBalance() public view returns (uint256) {}
}
