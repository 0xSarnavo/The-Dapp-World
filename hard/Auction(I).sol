// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Auction {
    struct Item {
        uint currentPrice;
        uint endTime;
        address highestBidder;
        bool auctionActive;
        bool exists;
    }
    mapping(uint => Item) public items;

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can use");
        _;
    }

    function createAuction(uint256 itemNumber, uint256 startingPrice, uint256 duration) public onlyOwner {
        Item storage item = items[itemNumber];
        require(!item.exists, "Auction already exists");
        require(startingPrice > 0, "Starting price must be greater than 0");
        require(duration > 0, "Duration must be greater than 0");

        item.currentPrice = startingPrice;
        item.endTime = block.timestamp + duration;
        item.auctionActive = true;
        item.exists = true;
    }

    function bid(uint256 itemNumber, uint256 bidAmount) public payable {
        require(msg.value > 0, "Insufficient Amount");
        Item storage item = items[itemNumber];
        require(msg.sender != owner && item.auctionActive, "Bid not allowed");
        require(block.timestamp < item.endTime, "Auction time over");
        require(bidAmount > item.currentPrice, "Place a higher bid");

        item.highestBidder = msg.sender;
        item.currentPrice = bidAmount;
    }

    function cancelAuction(uint256 itemNumber) public onlyOwner {
        Item storage item = items[itemNumber];
        require(item.exists && item.auctionActive, "Cancellation not allowed");
        require(block.timestamp < item.endTime, "Auction time over");

        item.auctionActive = false;
    }

    function timeLeft(uint256 itemNumber) public view returns (uint256)
		 {
			require(items[itemNumber].auctionActive == true, "Auction is Cancelled");
			return (items[itemNumber].endTime)-block.timestamp;
		 }

    function checkHighestBidder(uint256 itemNumber) public view returns (address) {
        Item storage item = items[itemNumber];
        return item.auctionActive ? item.highestBidder : address(0);
    }

    function checkActiveBidPrice(uint256 itemNumber) public view returns (uint256) {
        Item storage item = items[itemNumber];
        require(item.auctionActive, "Auction is Cancelled");
        return item.currentPrice;
    }

    function checkAuctionActive(uint256 itemNumber) public view returns (bool) {
    return items[itemNumber].auctionActive;
    }
}
