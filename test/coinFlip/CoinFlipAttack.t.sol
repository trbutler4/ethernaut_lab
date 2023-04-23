// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../../src/coinFlip/CoinFlipAttack.sol";
import "../../src/coinFlip/CoinFlip.sol";

contract CoinFlipAttackTest is Test {

    CoinFlip public coinFlip = new CoinFlip();
    CoinFlipAttack public coinFlipAttack =
        new CoinFlipAttack(address(coinFlip));

    function setUp() public {
    }

    function test_attack() public {
        // make 10 guesses
        uint n = 10;
        for (uint i = 0; i < n; i++){
            coinFlipAttack.make_guess();
            vm.roll(block.number + 1); //advance 1 block
        }

        // get 10 wins
        uint256 wins = coinFlip.consecutiveWins();
        assertEq(wins, n);

    }
}
