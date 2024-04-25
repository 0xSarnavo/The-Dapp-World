// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoTrader {
    function roundTrip(int[] memory walletBalances, int[] memory networkFees) public pure returns (int) {
        uint n = walletBalances.length;
        for (uint start = 0; start < n; start++) {
            if (isRoundTripPossible(walletBalances, networkFees, start)) {
                return int(start);
            }
        }
        return -1;
    }

    function isRoundTripPossible(int[] memory walletBalances, int[] memory networkFees, uint start) private pure returns (bool) {
        uint n = walletBalances.length;
        int balance = 0;
        
        for (uint i = 0; i < n; i++) {
            uint idx = (start + i) % n;
            balance += walletBalances[idx] - networkFees[idx];
            if (balance < 0) {
                return false;
            }
        }
        return true;
    }
}
