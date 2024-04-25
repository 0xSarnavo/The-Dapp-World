// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TokenSale {
    constructor(
        uint256 _totalSupply,
        uint256 _tokenPrice,
        uint256 _saleDuration
    ) {}

    function checkTokenPrice() public returns (uint256) {}

    function purchaseToken(address referrer) public {}

    function saleTimeLeft() public returns (uint256) {}

    function checkTokenBalance(address buyer) public returns (uint256) {}

    function sellTokenBack(uint256 amount) public {}

    function getReferralCount(address referrer) public returns (uint256) {}

    function getReferralRewards(address referrer) public returns (uint256){}
}