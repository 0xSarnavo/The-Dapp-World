// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShipmentService {

    address public owner;
    mapping (address=>uint) private OTP;
    mapping (address=>uint) public delivered;
    mapping (address=>string) public customers;
    mapping (address=>bool) public active;

    constructor () {
        owner=msg.sender;
    }

    modifier onlyOwner () {
        require(msg.sender==owner);
        _;
    }

    //This function inititates the shipment
    function shipWithPin(address customerAddress, uint pin) public onlyOwner {
        require(active[customerAddress]==false,"Active Shipment");
        require(customerAddress!=owner,"Owner can't be customer");
        require(pin>999 && pin<10000,"Enter pin between 999 to 10,000");
        OTP[customerAddress]=pin;
        customers[customerAddress]= "shipped";
        active[customerAddress]=true;
    }

    //This function acknowlegdes the acceptance of the delivery
    function acceptOrder(uint pin) public {
        require(pin==OTP[msg.sender],"Incorret Pin");
        delivered[msg.sender]+=1;
        customers[msg.sender]= "delivered";
        active[msg.sender]=false;
    }

    //This function outputs the status of the delivery
    function checkStatus(address customerAddress) public view returns (string memory){
        require(msg.sender==customerAddress || msg.sender==owner);
        if(keccak256(bytes(customers[customerAddress])) == keccak256(bytes("shipped")))
            return "shipped";
        else if(keccak256(bytes(customers[customerAddress])) == keccak256(bytes("delivered")))
            return "delivered";
        else 
            return "no orders placed";
    }

    //This function outputs the total number of successful deliveries
    function totalCompletedDeliveries(address customerAddress) public view returns (uint) {
        require(msg.sender==customerAddress || msg.sender==owner);
        return delivered[customerAddress];
    }
}