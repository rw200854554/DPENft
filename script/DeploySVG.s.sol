//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {SVGStorage} from "../src/SVGStorage.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeploySVG is Script {
    function run() external {
        vm.startBroadcast();
        new SVGStorage();
        vm.stopBroadcast();
    }
}
