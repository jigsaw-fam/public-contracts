// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract BurnToMintV3 is ERC721A, Ownable {

    // config
    constructor() ERC721A("Burn to Mint v3", "BURN") {
        //_checkSupplyAndMint(MASTER_WALLET, MAX_MINT_PER_WALLET);
    }
    uint256 public MAX_SUPPLY = 10_000;
    uint256 public MAX_MINT_PER_WALLET = 5;
    uint256 public START_ID = 1;
    address private MASTER_WALLET = 0x6fF5723435b7dfC2371B57Fb5cB4c373E5995C78;
    address public BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    bool public mintEnabled = true;
    string public baseURI;
    IERC721 public burnableNFT;

    // REQUIRE: set burnable NFT
    function setBurnableNFT(address nftAddress) external onlyOwner {
        burnableNFT = IERC721(nftAddress);
    }

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

    // toggle sale
    function toggleSale() external onlyOwner {
        mintEnabled = !mintEnabled;
    }

    // mint
    function mint(uint256[] memory _tokenIds) external {
        uint quantity = _tokenIds.length; // burn 1:1
        require(mintEnabled, "Sale is not enabled");
        require(_numberMinted(msg.sender) + quantity <= MAX_MINT_PER_WALLET, "Over wallet limit");
        require(_totalMinted() + quantity <= MAX_SUPPLY, "Over supply");
        // burn
        for (uint i = 0; i < _tokenIds.length; i++) {
            require(burnableNFT.ownerOf(_tokenIds[i]) == msg.sender, "Minter is not NFT owner");
            burnableNFT.transferFrom(msg.sender, BURN_ADDRESS, _tokenIds[i]);
        }
        _mint(msg.sender, quantity);
    }
    function adminMint(uint quantity) external onlyOwner {
        require(_totalMinted() + quantity <= MAX_SUPPLY, "Over supply");
        _mint(msg.sender, quantity);
    }

    // aliases
    function numberMinted(address owner) external view returns (uint256) {
        return _numberMinted(owner);
    }
    function remainingSupply() external view returns (uint256) {
        return MAX_SUPPLY - _totalMinted();
    }

    // transfer ownership
    function masterTransfer() external onlyOwner {
        transferOwnership(MASTER_WALLET);
    }

}
