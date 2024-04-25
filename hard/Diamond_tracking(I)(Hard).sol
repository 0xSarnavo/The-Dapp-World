// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DiamondLedger {

    mapping (uint=>uint) private ledger;

    function importDiamonds(uint[] calldata weights) public {

        unchecked {
            for(uint i=0; i<weights.length;) {
                ++ledger[weights[i]];
                ++i;
            }
        }    
    }

    function availableDiamonds(uint weight, uint allowance) public view returns(uint) {
        uint result=ledger[weight];

        unchecked {
            for(uint i=1; i<=allowance;) {
                result=result+ledger[weight-i];
                result=result+ledger[weight+i];
                ++i;
            }
        }

        return result;
    }

}