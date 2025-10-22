//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DPENft is ERC721 {
    error DPENft__CantFlipIfNotOwner();
    error DPENft__SVGNotSetYet();
    error DPENft__OnlyCallableByOwner();
    error DPENft__MinimumOfOneCentETH();
    error DPENft__NoMoreDPEInStorageForNow(uint256 tokenId);

    uint256 private s_tokenCounter;
    string[] private s_dpeSideSvgImgUri;
    string[] private s_dpeFrontSvgImgUri;
    string[] private s_dpeDescription;
    address private immutable i_owner;
    uint256 private s_minimum_cost = 0.05 ether;
    uint256 private s_storageCounter;
    string[] private s_dpeNames;

    enum View {
        RIGHT,
        FRONT
    }
    mapping(uint256 => View) private s_tokenId2View;

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert DPENft__OnlyCallableByOwner();
        _;
    }

    constructor(
        string memory dpeSideImgUri,
        string memory dpeFrontImgUri,
        string memory description,
        string memory dpe
    ) ERC721("DPenguin", "DPE") {
        s_tokenCounter = 0;
        i_owner = msg.sender;
        s_dpeFrontSvgImgUri.push(dpeFrontImgUri);
        s_dpeSideSvgImgUri.push(dpeSideImgUri);
        s_storageCounter = 0;
        s_dpeDescription.push(description);
        s_dpeNames.push(dpe);
    }

    function mintNft() public payable {
        if (msg.sender != i_owner && msg.value < s_minimum_cost)
            revert DPENft__MinimumOfOneCentETH();
        if (s_tokenCounter > s_storageCounter)
            revert DPENft__NoMoreDPEInStorageForNow(s_tokenCounter);
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenId2View[s_tokenCounter] = View.FRONT;
        s_tokenCounter++;
    }

    function addDPE(
        string memory dpeFront,
        string memory dpeSide,
        string memory dpeDescription,
        string memory dpeName
    ) public onlyOwner {
        s_dpeFrontSvgImgUri.push(dpeFront);
        s_dpeSideSvgImgUri.push(dpeSide);
        s_dpeDescription.push(dpeDescription);
        s_dpeNames.push(dpeName);
        s_storageCounter++;
    }

    function withdraw() public onlyOwner {
        (bool success, ) = payable(address(msg.sender)).call{
            value: address(this).balance
        }("");
        require(success, "Call failed");
    }

    fallback() external payable {
        mintNft();
    }

    receive() external payable {
        mintNft();
    }

    function flipView(uint256 tokenId) public {
        if (msg.sender != _ownerOf(tokenId))
            revert DPENft__CantFlipIfNotOwner();
        if (s_tokenId2View[tokenId] == View.FRONT)
            s_tokenId2View[tokenId] = View.RIGHT;
        else s_tokenId2View[tokenId] = View.FRONT;
    }

    function getView(uint256 tokenId) public view returns (View) {
        return s_tokenId2View[tokenId];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imgUri;

        if (s_tokenId2View[tokenId] == View.FRONT)
            imgUri = s_dpeFrontSvgImgUri[tokenId];
        else imgUri = s_dpeSideSvgImgUri[tokenId];

        string memory description = s_dpeDescription[tokenId];
        string memory dpeName = s_dpeNames[tokenId];

        string memory tokenMetadata = string.concat(
            '{"name":"',
            dpeName,
            '", "description":"Cute little penguin friend","image":"',
            imgUri,
            '",',
            description,
            "}"
        );

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(bytes(abi.encodePacked(tokenMetadata)))
                )
            );
    }
}
