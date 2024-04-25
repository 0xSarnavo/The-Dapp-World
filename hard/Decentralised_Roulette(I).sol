// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Roulette is ERC20 {

    address owner;
    uint256 public SpinWheelResult;
    mapping (address => uint) betOnEven;
    mapping (address => uint) betOnOdd;
    mapping (address mapping(uint => uint)) betOnNumber;

    constructor() ERC20("Roulette", "RLT") {
        owner=msg.sender;
    }

    function setSpinWheelResult(uint256 key) public {
        require(msg.sender == owner);
        SpinWheelResult = key;
    }

    function buyTokens() public payable {
        require(msg.value>0);
        _mint(msg.sender, msg.value * 1000);
    }

    function placeBetEven(uint256 betAmount) public {
        require(betAmount>0);
        transferFrom(msg.sender, address(this), betamount);
        betOnEven[msg]=betAmount;
    }

    function placeBetOdd(uint256 betAmount) public {}

    function placeBetOnNumber(uint256 betAmount, uint256 number) public {}

    function spinWheel() public {}

    function sellTokens(uint256 tokenAmount) public {}

    function transferWinnings() public {}

    function checkBalance() public view returns (uint256) {}

    function checkWinningNumber() public view returns (uint256) {}

    function checkBetsOnEven()
        public
        view
        returns (address[] memory, uint256[] memory)
    {}

    function checkBetsOnOdd()
        public
        view
        returns (address[] memory, uint256[] memory)
    {}

    function checkBetsOnDigits()
        public
        view
        returns (
            address[] memory,
            uint256[] memory,
            uint256[] memory
        )
    {}
}
