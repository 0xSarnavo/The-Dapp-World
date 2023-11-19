// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    mapping(address => uint) public user_account;

    function deposit() public payable {
        require(msg.value > 0, "Deposit can't be 0");
        user_account[msg.sender] += (msg.value);
    }

    function withdraw(uint amount) public {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(user_account[msg.sender] >= (amount), "Insufficient balance");
        
        user_account[msg.sender] -=  amount;
        payable(msg.sender).transfer(amount *10 **18);
    }

    function get_balance() public view returns (uint) {
        return user_account[msg.sender];
    }
}
