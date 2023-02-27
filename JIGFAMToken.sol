// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

// copy from OPB Token (-/|\-)
// https://optimistic.etherscan.io/address/0x02c69ab98e0c8ef67fdb075bb964cbb69e33bc47#code
contract JIGFAM is ERC20Capped {

    uint256 public max_token_supply = 10 * 10**6 * 10**18;

    constructor() ERC20("JIGFAM Token", "JIGFAM") ERC20Capped(max_token_supply) {
        ERC20._mint(msg.sender, max_token_supply);
    }
}
