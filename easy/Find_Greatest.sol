// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    function Greater(uint256[] memory arr) public pure returns(uint256){
     uint256 greatest = 0;

     for (uint256 i=0; i<arr.length; i++){
      if (arr[i] > greatest) {
       greatest = arr[i];
      }
    }
    return greatest; 
}
}