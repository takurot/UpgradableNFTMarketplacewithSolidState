// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Diamond } from "@solidstate/contracts/proxy/diamond/Diamond.sol";
import { DiamondBaseStorage } from "@solidstate/contracts/proxy/diamond/DiamondBaseStorage.sol";

contract NFTMarketplaceDiamond is Diamond {
    constructor(address[] memory facets) {
        // Initialize facets (モジュールのアドレスを追加)
        DiamondBaseStorage.Layout storage layout = DiamondBaseStorage.layout();
        for (uint256 i = 0; i < facets.length; i++) {
            layout.facetAddresses.push(facets[i]);
        }
    }
}