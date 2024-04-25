// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Exchange {
    
    constructor(address token) {}

    /*
		 * @dev addLiquidity allows users to add liquidity to the exchange
     * @return Returns the amount of LP tokens to mint
		 */ 
    function addLiquidity(uint amountOfToken) public payable {}

    /*
     * @dev removeLiquidity allows users to remove liquidity from the exchange
     * @param amountOfLPTokens - amount of LP tokens user wants to burn to get back ETH and TOKEN
     * @return Returns the amount to ETH and tokens to be returned to the user
     */
    function removeLiquidity(
        uint256 amountOfLPTokens
    ) public {}

		/**
		 * @dev ethToTokenSwap allows users to swap ETH for TOKEN	
		 */
    function ethToTokenSwap() external payable {}

		/**
		 * @dev tokenToEthSwap allows users to swap TOKEN for ETH	
		 */
		function tokenToEthSwap(
        uint256 tokensToSwap
    ) public {}

		/**
		 * @dev getLPTokensToMint returns the amount of LP Tokens to be minted after addLiquidity has been called.
		 * @notice Only called just after addLiquidity, if it is successful.
		 * @return returns the LP Tokens to be minted to the liquidity provider 
		 */
		function getLPTokensToMint() public view returns (uint256) {}

		/**
		 * @dev getEthAndTokenToReturn returns the amount of ETH and Token that needs to be returned to the user when removeLiquidity is called.
		 * @return returns the amount of ETH and Token to be returned to the user when removeLiquidity is called.
		 * @notice only called just after removeLiquidity, if it is successful.
		 */
		function getEthAndTokenToReturn() public view returns (uint256, uint256) {}
    
    /**
		 * @dev getReserve returns the balanace of 'token' held by this contract
		 */
    function getReserve() public view returns (uint256) {}
}