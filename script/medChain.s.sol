// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/medChain.sol"; // adjust path as needed (ensure the filename and contract name match case-sensitively)

contract MedChainScript is Script {
    function run() external {
        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
