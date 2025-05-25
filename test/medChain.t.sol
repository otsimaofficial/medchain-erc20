// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/medChain.sol";

contract MedchainTest is Test {
    Medchain public token;

    function setUp() public {
        token = new Medchain(1000 * 1e18); // Initial supply
    }

    function testTransfer() public {
        address to = address(0xBEEF);
        token.transfer(to, 100 * 1e18);
        assertEq(token.balanceOf(to), 100 * 1e18);
    }

    function testApproveAndTransferFrom() public {
        address spender = address(this);
        address user = address(0xABCD);

        vm.prank(user);
        Medchain userToken = new Medchain(1000 * 1e18);
        vm.prank(user);
        userToken.approve(spender, 200 * 1e18);

        vm.prank(spender);
        userToken.transferFrom(user, spender, 100 * 1e18);

        assertEq(userToken.balanceOf(spender), 100 * 1e18);
    }
}
