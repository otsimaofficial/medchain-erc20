// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/medChain.sol";

contract MedchainTest is Test {
    Medchain token;
    string  NAME;
    string  SYMBOL;
    uint8  DECIMALS;
    uint256  TOTALSUPPLY; 
    address user2 = address(0xABCD);
    address user3 = address(0x1234);
    // Declare the Medchain contract instance and a user address for testing
    // The user2 & user3 address is used to simulate another user's interactions with the token

    function setUp() public {
        token = new Medchain(
            NAME = "Medchain Token",
            SYMBOL = "MED",
            DECIMALS = 18,
            TOTALSUPPLY= 1000 * (10 ** DECIMALS));
        // Initialize the token with a name, symbol, decimals, and total supply
        // The total supply is set to 1000 tokens with 18 decimals
        // This function is called before each test to set up the environment
    }

    function testconstructor() public view {
        assertEq(token.name(), NAME);
        assertEq(token.symbol(), SYMBOL);
        assertEq(token.decimals(), DECIMALS);
        assertEq(token.totalSupply(), TOTALSUPPLY);
        // Check that the constructor sets the name, symbol, decimals correctly and Check that the total supply matches the initial supply  
    }

    function testInitialBalance() public view {
        assertEq(token.balanceOf(address(this)), TOTALSUPPLY);
        // Check that the deployer (this contract) has the initial total supply of tokens
    }
    function testTransfer() public {
        uint256 amount = 100 * (10 ** DECIMALS);
        
        token.transfer (user2, amount);
        assertEq(token.balanceOf(user2), amount);
        assertEq(token.balanceOf(address(this)), TOTALSUPPLY - amount);
        // Check that the transfer function works correctly
        // The recipient's balance should increase by the transferred amount
        // The sender's balance should decrease by the same amount
    }

    function testApproveAndTransferFrom() public {
        uint256 amount = 150 * (10 ** DECIMALS);
        // Set up an allowance for user2 to spend tokens on behalf of this contract
        
        token.approve(user2, amount);
        assertEq(token.allowance(address(this), user2), amount);
        // Check that the approve function sets the allowance correctly

        vm.prank (user2);
        token.transferFrom(address(this), user3, amount);
        assertEq(token.balanceOf(user3), amount);
        assertEq(token.balanceOf(address(this)), TOTALSUPPLY - amount);
        // Check that the transferFrom function works correctly
        // The recipient's balance should increase by the transferred amount
        // The sender's balance should decrease by the same amount
    }
}
