// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@solidstate/contracts/token/ERC721/IERC721.sol";

contract BuyFacet {
    mapping(uint256 => Listing) public listings; // ListFacetと共有

    function buyNFT(uint256 listingId) external payable {
        Listing memory listing = listings[listingId];
        require(listing.price > 0, "Listing does not exist");
        require(msg.value == listing.price, "Incorrect price");

        address seller = listing.seller;
        address nftContract = listing.nftContract;
        uint256 tokenId = listing.tokenId;

        delete listings[listingId]; // リストから削除

        IERC721(nftContract).safeTransferFrom(seller, msg.sender, tokenId);
        payable(seller).transfer(msg.value);
    }
}