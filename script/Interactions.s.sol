//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

import {BasicNFT} from "../src/BasicNFT.sol";

import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

import {DPENft} from "../src/DPENft.sol";

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MintBasicNFT is Script {
    string public constant DPE =
        "https://ipfs.io/ipns/k51qzi5uqu5din4nw7tnp388c1geeeqg1de7mbvvpvuq4pet50ig3geasjr0x0";

    function mintNFTONContract(address latestDeploy) public {
        vm.startBroadcast();
        BasicNFT(latestDeploy).mintNFT(DPE);
        vm.stopBroadcast();
    }

    function run() external {
        address latestDeploy = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTONContract(latestDeploy);
    }
}

contract MintDPENFT is Script {
    function mintNFTONContract(address payable latestDeploy) public {
        vm.startBroadcast();
        DPENft(latestDeploy).mintNft();
        vm.stopBroadcast();
    }

    function run() external {
        address latestDeploy = DevOpsTools.get_most_recent_deployment(
            "DPENft",
            block.chainid
        );
        mintNFTONContract(payable(latestDeploy));
    }
}

// contract DestroyLastContract is Script {
//     function run() external {
//         address latestDeploy = DevOpsTools.get_most_recent_deployment(
//             "DPENft",
//             block.chainid
//         );
//         destroy(latestDeploy);
//     }

//     function destroy(address contr) public {
//         DPENft(contr).destruct();
//     }
// }

// contract SendSVG is Script {
//     string s2 = vm.readFile("./img/dpeFrontc.svg");
//     string s1 = vm.readFile("./img/dpeSidec.svg");

//     function run() external {
//         address latestDeploy = DevOpsTools.get_most_recent_deployment(
//             "DPENft",
//             block.chainid
//         );
//         sendSVG(latestDeploy);
//     }

//     function sendSVG(address latestDeploy) public {
//         vm.startBroadcast();
//         DPENft(latestDeploy).setSVG(svgToImgUri(s1), svgToImgUri(s2));
//         vm.stopBroadcast();
//     }

//     function svgToImgUri(
//         string memory svg
//     ) public pure returns (string memory) {
//         string memory baseUri = "data:img/svg+xml;base64,";
//         string memory svgBase64Encoded = Base64.encode(
//             bytes(string(abi.encodePacked(svg)))
//         );
//         return string.concat(baseUri, svgBase64Encoded);
//     }
//}
