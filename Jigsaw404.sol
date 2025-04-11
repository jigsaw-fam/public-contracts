//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./sample/ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Jigsaw is ERC404 {
    string public imageURI = "ipfs://bafkreiepzttf4bah7nzoodg2fbviwuabm4l56b5kv4xfoqvgktoprzrpna";

    constructor(
        address _owner
    ) ERC404("Jigsaw 404", "JIGSAW", 18, 10000, _owner) {
        balanceOf[_owner] = 10000 * 10 ** 18;
    }

    function setImgURI(string memory _imageURI) public onlyOwner {
        imageURI = _imageURI;
    }

    function setNameSymbol(
        string memory _name,
        string memory _symbol
    ) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        string memory jsonPreImage = string.concat(
            string.concat(
                string.concat('{"name": "Jigsaw #', Strings.toString(id)),
                '","description":"No matter what you are, In #fud-thai we are fam bro.","image":"'
            ),
            imageURI
        );
        string memory jsonPostImage = '"}';
        return
            string.concat(
                "data:application/json;utf8,",
                string.concat(jsonPreImage, jsonPostImage)
            );
    }
}
