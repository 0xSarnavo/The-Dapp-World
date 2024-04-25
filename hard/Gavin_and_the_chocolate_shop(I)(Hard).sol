// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ChcolateShop {
    uint256 private chocolates;
    int256[] private transactions;

    // this function allows gavin to buy n chocolates
    function buyChocolates(uint n) public {
        unchecked {
            chocolates += n;
        }
        transactions.push() = int(n);
    }

    // this function allows gavin to sell n chocolates
    function sellChocolates(uint n) public {
        require(chocolates >= n);
        unchecked {
            chocolates -= n;
        }
        transactions.push() = -int(n);
    }

    // this function returns total chocolates present in bag
    function chocolatesInBag() public view returns(uint){
        return chocolates;
    }

    // this function returns the nth transaction
    function showTransaction(uint n) public view returns(int) {
        return transactions[n - 1];
    }

    //this function returns the total number of transactions
    function numberOfTransactions() public view returns(uint) {
        return transactions.length;
    }

}