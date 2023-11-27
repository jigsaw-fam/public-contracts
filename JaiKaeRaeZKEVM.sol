// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract JaiKaeRae is ERC721A {

    // config
    constructor() ERC721A("Jai Kae Rae", "JKR") {
        _mint(msg.sender, MAX_SUPPLY);
    }
    uint256 public MAX_SUPPLY = 1_000;
    string public baseURI = "ipfs://bafybeicb5ll4baqbwkxbhb2pigm4llahtu4cicotxvxwwsjox3qgw6xlbe/";

    // metadata
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string.concat(baseURI, Strings.toString(tokenId), ".json");
    }

}
