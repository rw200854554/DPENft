//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DPENft} from "../src/DPENft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract SVGStorage is Script {
    string s_dpeSide = svgToImgUri(vm.readFile("./img/dpeFront.svg"));
    string s_dpeFront = svgToImgUri(vm.readFile("./img/dpeSide.svg"));

    function svgToImgUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseUri = "data:img/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string.concat(baseUri, svgBase64Encoded);
    }
}
