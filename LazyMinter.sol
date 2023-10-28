// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LazyMinter is ERC721A, Ownable {

    // config
    constructor() ERC721A("Lazy Minter", "LAZYMINTER") {}
    uint256 public START_ID = 1;
    string public baseURI;

    // start token id
    function _startTokenId() internal view virtual override returns (uint256) {
        return START_ID;
    }

    // metadata
    function setBaseURI(string calldata _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string.concat(baseURI, Strings.toString(tokenId), ".json");
    }

    // mint
    function adminMint(uint quantity) external onlyOwner {
        _mint(msg.sender, quantity);
    }

}
