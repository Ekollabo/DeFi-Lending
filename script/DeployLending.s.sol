//SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {Lending} from "../src/Lending.sol";

contract DeployLending is Script {
    function run() external returns (Lending) {
        vm.startBroadcast();
        Lending lending = new Lending();
        vm.stopBroadcast();
        return lending;
    }
}