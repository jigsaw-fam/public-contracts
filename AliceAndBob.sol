// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC1155/presets/ERC1155PresetMinterPauser.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {DefaultOperatorFilterer} from "operator-filter-registry/src/DefaultOperatorFilterer.sol";

contract AliceAndBob is ERC1155PresetMinterPauser, DefaultOperatorFilterer {

    string public name = "Alice and Bob";
    string public symbol = "ANB";

    constructor() ERC1155PresetMinterPauser("") {

        // (optional) mint existing items
        _mint(msg.sender, 1, 1, "");
        _mint(msg.sender, 2, 3, "");
        _mint(msg.sender, 3, 5, "");
    }

    // metadata
    string private baseURI;
    function setBaseURI(string calldata _newBaseURI) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "setBaseURI require admin role");
        baseURI = _newBaseURI;
    }
    function tokenURI(uint tokenId) public view returns (string memory) {
        return string.concat(baseURI, Strings.toString(tokenId), ".json");
    }

    // https://github.com/ProjectOpenSea/operator-filter-registry/blob/main/src/example/ExampleERC1155.sol
    function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
        super.setApprovalForAll(operator, approved);
    }
    function safeTransferFrom(address from, address to, uint256 tokenId, uint256 amount, bytes memory data)
        public
        override
        onlyAllowedOperator(from)
    {
        super.safeTransferFrom(from, to, tokenId, amount, data);
    }
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override onlyAllowedOperator(from) {
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }

}
