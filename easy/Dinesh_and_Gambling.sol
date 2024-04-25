// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SecondLargest {

    //this function outputs the second largest integer in the array
     function findSecondLargest(int[] memory arr) public pure returns (int) {
       uint i; uint j;
       bool swapped;
       for (i = 0; i < arr.length - 1; i++) {
         swapped = false;
         for (j = 0; j < arr.length - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int store=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=store;
                swapped = true;
            }
         }
         if (swapped == false)
            break;
        }
        return arr[arr.length-2];
  }
}

