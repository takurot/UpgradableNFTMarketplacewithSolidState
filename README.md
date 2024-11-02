# Upgradable NFT Marketplace with SolidState

This project implements an upgradable NFT marketplace using the SolidState library's diamond storage pattern. The marketplace allows dynamic functionality for listing, buying, and auctioning NFTs, where each feature is modularized into separate facets. This design enables seamless upgrades and scalability without modifying the core contract structure.

## Features

- **Diamond Storage Pattern**: Utilizes SolidState's diamond proxy and facets for modular and upgradeable smart contract functionality.
- **NFT Listing**: Users can list their NFTs for sale with customizable prices.
- **NFT Purchasing**: Buyers can purchase NFTs listed on the marketplace.
- **NFT Auctions**: Supports auction functionality, where users can bid on NFTs within a specific time frame.
- **Shared Storage**: All facets share common storage to ensure data consistency and efficient access across modules.

## File Structure

```plaintext
contracts/
├── NFTMarketplaceDiamond.sol      // Diamond proxy contract for managing facets
├── ListFacet.sol                  // Facet for listing NFTs
├── BuyFacet.sol                   // Facet for buying NFTs
├── AuctionFacet.sol               // Facet for auction functionality
└── MarketplaceStorage.sol         // Shared storage definitions
```

## Contracts Overview

### 1. Diamond Proxy Contract (NFTMarketplaceDiamond.sol)

The `NFTMarketplaceDiamond` contract functions as the central proxy that delegates calls to the different facets. It initializes with a list of facet addresses, which enables it to route specific functions to the correct facet.

### 2. List Facet (ListFacet.sol)

The `ListFacet` contract handles NFT listings. It allows users to list their NFTs for sale, specifying a price. The NFT must be approved for transfer by the marketplace contract to ensure ownership is properly transferred during sale.

### 3. Buy Facet (BuyFacet.sol)

The `BuyFacet` contract enables users to purchase listed NFTs. When a buyer sends the correct amount, the NFT is transferred to the buyer, and the payment is forwarded to the seller.

### 4. Auction Facet (AuctionFacet.sol)

The `AuctionFacet` contract provides the auction functionality. Sellers can create auctions, where users can place bids on an NFT. The auction ends after a specified time, and the highest bidder wins the NFT if they have placed a valid bid.

### 5. Marketplace Storage (MarketplaceStorage.sol)

The `MarketplaceStorage` file defines the shared storage structure that each facet uses. This ensures data consistency across facets and simplifies access to marketplace data, such as listings and auction information.

## Usage

### Installation

1. **Install Dependencies**: Install the required OpenZeppelin and SolidState libraries.

   ```bash
   npm install @openzeppelin/contracts @solidstate/contracts
   ```

2. **Deploy Contracts**: Use a development framework like Hardhat or Truffle to deploy each facet and initialize the `NFTMarketplaceDiamond` contract with the facet addresses.

### Example Workflow

1. **List an NFT**: 
   - Use `ListFacet` to list an NFT for sale by specifying the price and ensuring the NFT is approved for transfer.

2. **Buy an NFT**:
   - A buyer can call the `buyNFT` function in `BuyFacet` and send the appropriate payment to purchase a listed NFT.

3. **Create and Participate in an Auction**:
   - Use `AuctionFacet` to create an auction, place bids, and end the auction to transfer the NFT to the highest bidder.

## Benefits of Using SolidState

- **Upgradability**: Facets can be individually upgraded without impacting other modules.
- **Modularity**: Each functionality (listing, buying, auctions) is separated, making it easy to extend or modify.
- **Efficient Storage Management**: Diamond storage pattern ensures consistent and optimized storage usage across facets.

## Notes

- **Access Control**: Consider implementing access control (e.g., `onlyOwner`) on sensitive functions to restrict permissions.
- **Marketplace Compatibility**: Ensure that any additional NFT standards are compatible with your marketplace for broader support.

## License

This project is licensed under the MIT License.
