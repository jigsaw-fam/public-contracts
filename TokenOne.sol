// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenOne is ERC20 {
    constructor() ERC20("TokenOne", "TK1") {
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }
}
