// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LotteryPool {

    uint count;
    address lastWinner;
    address[] participants;
    uint randNonce = 0;
    
    // For participants to enter the pool
    function enter() public payable {
        require(msg.sender==owner,"owner can't participate");
        require(msg.value==)
    }

    // To view participants in current pool
    function viewParticipants() public view returns (address[] memory, uint) {}

    // To view winner of last lottery
    function viewPreviousWinner() public view returns (address) {}
}
