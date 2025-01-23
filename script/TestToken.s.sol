// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {TestToken} from "../src/TestToken.sol";

contract TestTokenScript is Script {
    function run() public {
        vm.startBroadcast();
        new TestToken();
        vm.stopBroadcast();
    }
}
