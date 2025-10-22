//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DPENft} from "../../src/DPENft.sol";
import {DeployDPENft} from "../../script/DeployDPENft.s.sol";

contract DPENftTest is Test {
    DPENft dpe;
    address USER = makeAddr("USER");
    DeployDPENft ddpe;

    function setUp() public {
        ddpe = new DeployDPENft();
        dpe = ddpe.run();
    }

    function testConvertSvgToUri() public {
        vm.prank(USER);
        dpe.mintNft();
        console.log(dpe.tokenURI(0));
    }

    function testIfSurpassStorageFail() public {
        vm.prank(USER);
        dpe.mintNft();
        vm.prank(USER);
        vm.expectRevert(
            abi.encodeWithSelector(
                DPENft.DPENft__NoMoreDPEInStorageForNow.selector,
                1
            )
        );
        dpe.mintNft();
    }
}
