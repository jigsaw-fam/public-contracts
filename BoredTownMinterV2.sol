// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface V2Interface {
    function numberMinted(address owner) external view returns (uint256);
    function remainingSupply() external view returns (uint256);
    function mint(address to, uint256 amount) external;
}

contract BoredTownMinterV2 is Ownable {

    // config
    bool public mintEnabled = false;
    string private secret = "ILOVEMINTDOTFUN";

    // target contract
    address public targetAddress;
    V2Interface private targetContract;
    function setTarget(address _addr) external onlyOwner {
        targetAddress = _addr;
        targetContract = V2Interface(_addr);
    }

    // toggle sale
    function toggleSale() external onlyOwner {
        mintEnabled = !mintEnabled;
    }

    // mint
    function mint(uint quantity, string calldata _secret) external {
        require(mintEnabled, "Sale is not enabled");
        require(Strings.equal(secret, _secret), "Invalid secret");
        
        targetContract.mint(msg.sender, quantity);
    }

    // aliases
    function numberMinted(address owner) external view returns (uint256) {
        return targetContract.numberMinted(owner);
    }
    function remainingSupply() external view returns (uint256) {
        return targetContract.remainingSupply();
    }

    // eth
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

}
