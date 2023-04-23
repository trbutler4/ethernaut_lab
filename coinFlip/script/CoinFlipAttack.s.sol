// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/CoinFlipAttack.sol";


contract CoinFlipAttackScript is Script {

    function run() external {

        uint256 deployerPrivateKey = vm.envUint("DEV_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        address target = 0x9240670dbd6476e6a32055E52A0b0756abd26fd2;
        CoinFlipAttack coinFlipAttack = new CoinFlipAttack(target);
        console.log("CoinFlipAttack deployed to: ", address(coinFlipAttack));

        vm.stopBroadcast();
    }
}
