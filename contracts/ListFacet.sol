// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@solidstate/contracts/token/ERC721/IERC721.sol";

contract ListFacet {
    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
    }

    mapping(uint256 => Listing) public listings;
    uint256 private listingCounter;

    function listNFT(address nftContract, uint256 tokenId, uint256 price) external {
        require(IERC721(nftContract).ownerOf(tokenId) == msg.sender, "Not NFT owner");
        require(IERC721(nftContract).isApprovedForAll(msg.sender, address(this)), "Not approved");

        listings[listingCounter] = Listing({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            price: price
        });

        listingCounter++;
    }
}