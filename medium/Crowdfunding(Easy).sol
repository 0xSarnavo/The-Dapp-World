// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    uint256 private immutable priceInUSD;

    constructor(string memory _name, string memory _symbol, uint256 _priceInUSD)
        ERC20(_name, _symbol)
        Ownable(msg.sender)
    {
        priceInUSD = _priceInUSD;
    }

    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    function getTokenPriceInUSD() external view returns (uint256) {
        return priceInUSD;
    }
}

contract CrowdFundEasy {

    MyToken public Token;
    uint price;

    struct Campaign {
        address owner;
        uint256 goal;
        uint256 endTime;
        uint256 totalFunds;
        mapping (address => uint256) contributions;
    }
    uint numCampaigns=0;

    mapping (uint => Campaign) campaigns;
    
    /*
    * @param _tokens list of allowed token addresses
    */
    constructor(address _token) {
        Token = MyToken(_token);
        price = Token.getTokenPriceInUSD();
    }

    /**
     * @notice createCampaign allows anyone to create a campaign
     * @param _goal amount of funds to be raised in USD
     * @param _duration the duration of the campaign in seconds
     */
    function createCampaign(uint256 _goal, uint256 _duration) external {
        require(_goal > 0 && _duration > 0, "Goal and duration must be greater than zero");
        numCampaigns++;
        campaigns[numCampaigns].owner = msg.sender;
        campaigns[numCampaigns].goal = _goal;
        campaigns[numCampaigns].endTime = block.timestamp + _duration;
    }

    /**
     * @dev contribute allows anyone to contribute to a campaign
     * @param _id the id of the campaign
     * @param _amount the amount of tokens to contribute
     */
    function contribute(uint256 _id, uint256 _amount) external payable  {
        require(msg.sender != campaigns[_id].owner);
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(_amount >0);
        require(block.timestamp < campaigns[_id].endTime, "Campaign has ended");
        Token.transferFrom(msg.sender, address(this), _amount);
        campaigns[_id].totalFunds = campaigns[_id].totalFunds + _amount;
        campaigns[_id].contributions[msg.sender]=campaigns[_id].contributions[msg.sender]+ _amount;
    }

    /**
     * @dev cancelContribution allows anyone to cancel their contribution
     * @param _id the id of the campaign
     */
    function cancelContribution(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(campaigns[_id].contributions[msg.sender] != 0);
        Token.transfer(msg.sender, campaigns[_id].contributions[msg.sender]);
        campaigns[_id].totalFunds = campaigns[_id].totalFunds - campaigns[_id].contributions[msg.sender];
        campaigns[_id].contributions[msg.sender]=0;
    }

    /**
     * @notice withdrawFunds allows the creator of the campaign to withdraw the funds
     * @param _id the id of the campaign
     */

    function withdrawFunds(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(block.timestamp > campaigns[_id].endTime);
        require(msg.sender == campaigns[_id].owner);
        require(campaigns[_id].totalFunds * price >= campaigns[_id].goal);
        Token.transfer(campaigns[_id].owner, campaigns[_id].totalFunds);
        campaigns[_id].totalFunds=0;
    }

    /*
     * @notice refund allows the contributors to get a refund if the campaign failed
     * @param _id the id of the campaign
     */
    function refund(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(campaigns[_id].totalFunds * price < campaigns[_id].goal);
        require(campaigns[_id].contributions[msg.sender] != 0);
        Token.transfer(msg.sender, campaigns[_id].contributions[msg.sender]);
        campaigns[_id].totalFunds = campaigns[_id].totalFunds - campaigns[_id].contributions[msg.sender];
        campaigns[_id].contributions[msg.sender]=0;
    }

    /*
     * @notice getContribution returns the contribution of a contributor in USD
     * @param _id the id of the campaign
     * @param _contributor the address of the contributor
     */
    function getContribution(uint256 _id, address _contributor) public view returns (uint256) {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        return campaigns[_id].contributions[_contributor]*price;
    }
        
    /*
    * @notice getCampaign returns details about a campaign
    * @param _id the id of the campaign
    * @return remainingTime the time (in seconds) when the campaign ends
    * @return goal the goal of the campaign (in USD)
    * @return totalFunds total funds (in USD) raised by the campaign
    */
    function getCampaign(uint256 _id) external view returns (uint256 _remainingTime, uint256 _goal, uint256 _totalFunds) {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        uint256 remainingTime = campaigns[_id].endTime > block.timestamp ? campaigns[_id].endTime - block.timestamp : 0;
        return (remainingTime, campaigns[_id].goal, campaigns[_id].totalFunds*price);
    }
}
