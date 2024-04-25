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

contract CrowdFund {

    address[] tokensList;
    mapping (address => MyToken) public token;
    mapping (address => bool) allowedToken;
    mapping (address => uint) price;
    

    struct Campaign {
        address owner;
        uint256 goal;
        uint256 endTime;
        mapping (address => uint256) contributions;
        mapping (address => mapping (address => uint)) myTokens;
        mapping (address => bool) contributed;
        bool withdrawn;
    }
    uint numCampaigns=0;

    mapping (uint => Campaign) campaigns;
	/**
	* @param _tokens list of allowed token addresses
	*/
	constructor(address[] memory _tokens) {
        for(uint i=0; i < _tokens.length; i++) {
            token[_tokens[i]] = MyToken(_tokens[i]);
            price[_tokens[i]] = token[_tokens[i]].getTokenPriceInUSD();
            allowedToken[_tokens[i]] = true;
            tokensList.push(_tokens[i]);
        }
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
     * @param _token the address of the token to contribute
     * @param _amount the amount of tokens to contribute
     */
    function contribute(uint256 _id, address _token, uint256 _amount) external {
        require(msg.sender != campaigns[_id].owner);
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(_amount > 0);
        require(block.timestamp < campaigns[_id].endTime, "Campaign has ended");
        require(allowedToken[_token] == true);
        token[_token].transferFrom(msg.sender, address(this), _amount);
        campaigns[_id].myTokens[msg.sender][_token] = campaigns[_id].myTokens[msg.sender][_token] + _amount;
        campaigns[_id].contributions[_token] = campaigns[_id].contributions[_token] + _amount;
        campaigns[_id].contributed[msg.sender] = true;
    }

    /**
     * @dev cancelContribution allows anyone to cancel their contribution
     * @param _id the id of the campaign
     */
    function cancelContribution(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(campaigns[_id].contributed[msg.sender] == true);
        for(uint i = 0; i < tokensList.length; i++) {
            if(campaigns[_id].myTokens[msg.sender][tokensList[i]] != 0) {
                MyToken(tokensList[i]).transfer(msg.sender,campaigns[_id].myTokens[msg.sender][tokensList[i]]);
                campaigns[_id].myTokens[msg.sender][tokensList[i]]=0;
            }
        }
    }

    /**
     * @notice withdrawFunds allows the creator of the campaign to withdraw the funds
     * @param _id the id of the campaign
     */
    function withdrawFunds(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(block.timestamp > campaigns[_id].endTime);
        require(msg.sender == campaigns[_id].owner);
        require(campaigns[_id].withdrawn == false);
        uint totalFunds = 0;
        for(uint i = 0; i < tokensList.length; i++) {
            uint noOfTokens = campaigns[_id].contributions[tokensList[i]];
            uint tokenPrice = price[tokensList[i]];
            totalFunds = totalFunds + (noOfTokens * tokenPrice);
        }
        require(campaigns[_id].goal <= totalFunds);

        for(uint i = 0; i < tokensList.length; i++) {
            if(campaigns[_id].contributions[tokensList[i]] != 0) {
                MyToken(tokensList[i]).transfer(campaigns[_id].owner,campaigns[_id].contributions[tokensList[i]]);
                campaigns[_id].contributions[tokensList[i]]=0;
            }
        }
        campaigns[_id].withdrawn = true;
    }

    /**
     * @notice refund allows the contributors to get a refund if the campaign failed
     * @param _id the id of the campaign
     */
    function refund(uint256 _id) external {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(block.timestamp > campaigns[_id].endTime);
        require(campaigns[_id].contributed[msg.sender] == true);
        uint totalFunds = 0;
        for(uint i = 0; i < tokensList.length; i++) {
            uint noOfTokens = campaigns[_id].contributions[tokensList[i]];
            uint tokenPrice = price[tokensList[i]];
            totalFunds = totalFunds + (noOfTokens * tokenPrice);
        }
        require(campaigns[_id].goal > totalFunds);

        for(uint i = 0; i < tokensList.length; i++) {
            if(campaigns[_id].myTokens[msg.sender][tokensList[i]] != 0) {
                MyToken(tokensList[i]).transfer(msg.sender,campaigns[_id].myTokens[msg.sender][tokensList[i]]);
                campaigns[_id].myTokens[msg.sender][tokensList[i]]=0;
            }
        }
    }

    /**
     * @notice getContribution returns the contribution of a contributor in USD
     * @param _id the id of the campaign
     * @param _contributor the address of the contributor
     */
    function getContribution(uint256 _id, address _contributor) external view returns (uint256) {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        uint amount = 0;
        for(uint i = 0; i < tokensList.length; i++) {
            uint noOfTokens = campaigns[_id].myTokens[_contributor][tokensList[i]];
            uint tokenPrice = price[tokensList[i]];
            amount = amount + (noOfTokens * tokenPrice);
        }
        return amount;
    }

    /*
     * @notice getCampaign returns details about a campaign
     * @param _id the id of the campaign
     * @return remainingTime the time (in seconds) remaining for the campaign
     * @return goal the goal of the campaign (in USD)
     * @return totalFunds total funds (in USD) raised by the campaign
     */
    function getCampaign(uint256 _id) external view returns (uint256 _remainingTime, uint256 _goal, uint256 _totalFunds) {
        require(_id > 0 && _id <= numCampaigns, "Invalid campaign id");
        require(campaigns[_id].withdrawn == false);
        uint256 remainingTime = campaigns[_id].endTime > block.timestamp ? campaigns[_id].endTime - block.timestamp : 0;
        uint256 totalFunds = 0;
        for(uint i = 0; i < tokensList.length; i++) {
            uint256 noOfTokens = campaigns[_id].contributions[tokensList[i]];
            if(noOfTokens > 0) {
                uint256 tokenPrice = price[tokensList[i]];
                totalFunds += (noOfTokens * tokenPrice);
            }
        }
        return (remainingTime, campaigns[_id].goal, totalFunds);
    }
}
