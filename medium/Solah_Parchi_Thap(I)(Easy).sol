// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolahParchiThap {
    
    // To set and start the game
    function setState(address[4] players, uint8[4][4] parchis) public {}

    // To pass the parchi to next player
    function passParchi(uint8 parchi) public {}

    // To claim win
    function claimWin() public {}

    // To end the game
    function endGame() public {}

    // To see the number of wins
    function getWins(address add) public view returns (uint256) {}

    // To see the parchis held by the caller of this function
    function myParchis() public view returns (uint8[4]) {}

    // To get the state of the game
    function getState() public view returns (address[4], address, uint8[4][4]) {}

}
