// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MarketplaceStorage {
    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool active;
    }

    struct Auction {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 highestBid;
        address highestBidder;
        uint256 endTime;
        bool active;
    }

    struct Layout {
        mapping(uint256 => Listing) listings;
        mapping(uint256 => Auction) auctions;
        uint256 listingCounter;
        uint256 auctionCounter;
    }

    bytes32 internal constant STORAGE_SLOT = keccak256("marketplace.storage");

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
