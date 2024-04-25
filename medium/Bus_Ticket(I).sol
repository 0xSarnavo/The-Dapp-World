// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicketBooking {

    uint256[] seats [20];

    //To book seats
    function bookSeats(uint[] seatNumbers) public {
        require(seats.Length>0,"No more seat avia")
    }
    
    //To get available seats
    function showAvailableSeats() public  returns (uint[] memory) {}
    
    //To check availability of a seat
    function checkAvailability(uint seatNumber) public returns (bool) {}
    
    //To check tickets booked by the user
    function myTickets() public returns (uint[]) {}
}
