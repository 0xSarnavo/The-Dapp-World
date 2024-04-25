// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LotteryPool {
    uint public count;
    address public lastWinner;
    address[] public participants;
    uint public randNonce = 0;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function enter() external payable {
        require(msg.value == 0.1 ether, "0.1 Ether needed");
        require(participants.length < 5, "Pool is full");

        for (uint i = 0; i < participants.length; i++) {
            require(msg.sender != participants[i], "Sender is already a participant");
        }

        participants.push(msg.sender);

        if (participants.length == 5) {
            selectWinner();
        }
    }

    function selectWinner() internal {
        randNonce++;
        uint winnerIndex = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 5;
        address winner = participants[winnerIndex];
        payable(winner).transfer(0.5 ether);
        lastWinner = winner;
        resetPool();
    }

    function resetPool() internal {
        delete participants;
        randNonce = 0;
    }

    function viewParticipants() external view returns (address[] memory, uint) {
        return (participants, participants.length);
    }

    function viewPreviousWinner() external view returns (address) {
        return lastWinner;
    }
}
