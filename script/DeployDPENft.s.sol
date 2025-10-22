//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DPENft} from "../src/DPENft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployDPENft is Script {
    function run() external returns (DPENft) {
        string memory dpeFront = vm.readFile("./img/DPEFrontFinalc.svg");
        string memory dpeSide = vm.readFile("./img/miniDPEsidec.svg");
        string
            memory dpeDescription = '"attributes":[{"trait_type":"Headwear","value":"Straw hat"},{"trait_type":"Eyewear","value":"None"},{"trait_type":"Clothing","value":"None"},{"trait_type":"Neckwear","value":"None"},{"trait_type":"Occupation","value":"Gardener"},{"trait_type":"Hobby","value":"Gardening"},{"trait_type":"Background","value":"Yellow"},{"trait_type":"Held Items","value":"Tulip Flower"},{"trait_type":"Rarity","value":"Genesis"},{"trait_type":"Edition","value":"Genesis Edition"}]';
        //console.log(dpeFront, dpeSide);
        vm.startBroadcast();
        DPENft dpe = new DPENft(
            svgToImgUri(dpeSide),
            svgToImgUri(dpeFront),
            dpeDescription,
            "DPE"
        );
        /*svgToImgUri(dpeSide), svgToImgUri(dpeFront)*/
        vm.stopBroadcast();
        return dpe;
    }

    function svgToImgUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string.concat(baseUri, svgBase64Encoded);
    }
}
