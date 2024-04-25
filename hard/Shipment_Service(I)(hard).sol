// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShipmentService {

    //This function inititates the shipment
    function shipWithPin(address customerAddress, uint pin) public {}

    //This function acknowlegdes the acceptance of the delivery
    function acceptOrder(uint pin) public {}

    //This function outputs the status of the delivery
    function checkStatus(address customerAddress) public returns (uint){}

    //This function outputs the total number of successful deliveries
    function totalCompletedDeliveries(address customerAddress) public returns (uint) {}
}