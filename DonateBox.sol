// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DonateBox is Ownable {

    event Received(address sender, uint256 value);

    // withdraw
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    // prevent [execution reverted] when someone directly send ETH to this contract
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

}
