//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNft} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNft public deployer;
    BasicNFT public basicNft;
    address public USER = makeAddr("user");
    string public constant DPE =
        "https://ipfs.io/ipns/k51qzi5uqu5din4nw7tnp388c1geeeqg1de7mbvvpvuq4pet50ig3geasjr0x0";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expected = "Dpenguin";
        string memory actual = basicNft.name();
        assertEq(expected, actual);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNFT(DPE);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(DPE)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
