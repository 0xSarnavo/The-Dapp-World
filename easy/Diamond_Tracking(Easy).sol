// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract DiamondLedger {

    uint256[] public storages;

    // This function imports the diamonds
    function importDiamonds(uint[] memory weights) public {
        require(weights.length > 0, "Enter elements");
        for (uint i = 0; i < weights.length; i++) {
            require(weights[i] >= 0 && weights[i] <= 1000, "Weight should be between 0 and 1000");
            storages.push(weights[i]);
        }
    }

    // This function returns the total number of available diamonds as per the weight
    function availableDiamonds(uint weight) public view returns (uint) {
        require(weight >= 0 && weight <= 1000, "Please enter a valid weight");
        uint count;
        for (uint i = 0; i < storages.length; i++) {
            if (weight == storages[i]) {
                count++;
            }
        }

        return count;
    }
}