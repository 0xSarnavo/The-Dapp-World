// SPDX-License-Identifier: GPL-3.0 
pragma solidity >=0.4.22 <0.9.0; 
/// @title A contract for demonstrating random number generation in specific range
/// @author Jitendra Kumar
/// @notice For now, this contract just show how to generate a random number in specific range using keccak256
contract GeeksForGeeksRandom
{
	// Initializing the state variable
	uint randNonce = 0;

	// Defining a function to generate
	// a random number
	function randMod(uint _modulus) external returns(uint)
	{
		// increase nonce
		randNonce++;
		return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modulus;
	} 
}
