// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionFacet {
    struct Auction {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 highestBid;
        address highestBidder;
        uint256 endTime;
    }

    mapping(uint256 => Auction) public auctions;
    uint256 private auctionCounter;

    function createAuction(address nftContract, uint256 tokenId, uint256 startingBid, uint256 duration) external {
        auctions[auctionCounter] = Auction({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            highestBid: startingBid,
            highestBidder: address(0),
            endTime: block.timestamp + duration
        });

        auctionCounter++;
    }

    function placeBid(uint256 auctionId) external payable {
        Auction storage auction = auctions[auctionId];
        require(block.timestamp < auction.endTime, "Auction ended");
        require(msg.value > auction.highestBid, "Bid too low");

        if (auction.highestBid > 0) {
            payable(auction.highestBidder).transfer(auction.highestBid);
        }

        auction.highestBid = msg.value;
        auction.highestBidder = msg.sender;
    }

    function endAuction(uint256 auctionId) external {
        Auction storage auction = auctions[auctionId];
        require(block.timestamp >= auction.endTime, "Auction still active");
        require(auction.highestBidder != address(0), "No bids placed");

        delete auctions[auctionId];

        IERC721(auction.nftContract).safeTransferFrom(auction.seller, auction.highestBidder, auction.tokenId);
        payable(auction.seller).transfer(auction.highestBid);
    }
}