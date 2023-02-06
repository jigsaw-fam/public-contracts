// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/ERC721A.sol";
import "operator-filter-registry/src/DefaultOperatorFilterer.sol";

// Thanks Apetimism (-/|\-)
contract LockOSCreatorFee is ERC721A, Ownable, DefaultOperatorFilterer {

    string private _baseURIExtended;

    //
    // SYMBOL
    //
    constructor() ERC721A("LockOSCreatorFee", "LOCKFEE") {}

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

    //
    // LOCK OS CREATOR FEE
    // https://github.com/ProjectOpenSea/operator-filter-registry
    //
    function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
        super.setApprovalForAll(operator, approved);
    }
    function approve(address operator, uint256 tokenId) public override onlyAllowedOperatorApproval(operator) {
        super.approve(operator, tokenId);
    }
    function transferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.transferFrom(from, to, tokenId);
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId);
    }
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
        public
        override
        onlyAllowedOperator(from)
    {
        super.safeTransferFrom(from, to, tokenId, data);
    }

}
