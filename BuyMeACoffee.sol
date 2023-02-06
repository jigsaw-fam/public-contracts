// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/ERC721A.sol";

// Thanks Apetimism (-/|\-)
contract BuyMeACoffee is ERC721A, Ownable {

    string private _baseURIExtended;

    //
    // SYMBOL
    //
    constructor() ERC721A("BuyMeACoffee", "COFFEE") {}

    //
    // BASE_URI
    //
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIExtended;
    }
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseURIExtended = baseURI;
    }

    //
    // MINT <3
    //
    function mint(uint256 quantity) external payable onlyOwner {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    //
    // WITHDRAW
    //
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

}
