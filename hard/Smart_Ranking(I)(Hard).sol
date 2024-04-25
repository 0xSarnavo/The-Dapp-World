// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SmartRanking {

    uint[] private ranking;
    mapping (uint=>uint) private marks;

    // this function inserts the roll number and corresponding marks of a student
    function insertMarks(uint _rollNumber, uint _marks) public {
        require(_rollNumber > 0, "Invalid roll number");

        // Check for uniqueness of roll number
        for (uint i = 0; i < ranking.length; ++i) {
            require(ranking[i] != _rollNumber, "Roll number already exists");
        }

        // Insert marks and update ranking
        marks[_rollNumber] = _marks;
        ranking.push(_rollNumber);

        for (uint i = 1; i < ranking.length; ++i) {
            uint key = ranking[i];
            int j = int(i) - 1;

        // Insertion sort logic based on marks (for descending order)
        while (j >= 0 && marks[ranking[uint(j)]] < marks[key]) {
            ranking[uint(j + 1)] = ranking[uint(j)];
            j--;
        }
        ranking[uint(j + 1)] = key;
        }
    }

    //this function returnsthe marks obtained by the student as per the rank
    function scoreByRank(uint rank) public view returns(uint) {
        return marks[ranking[rank-1]];
    }

    //this function returns the roll number of a student as per the rank
    function rollNumberByRank(uint rank) public view returns(uint) {
        return ranking[rank-1];
        }
}
