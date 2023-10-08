// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

interface TargetInterface {
    function numberMinted(address owner) external view returns (uint256);
    function remainingSupply() external view returns (uint256);
    function mint(address to, uint256 amount) external;
}

contract BoredTownMinterV3 is Ownable {

    // config
    bool public mintEnabled = false;
    bool public wlRound = true;
    bytes32 public merkleRoot;

    // target contract
    address public targetAddress;
    TargetInterface private targetContract;
    function setTarget(address _addr) external onlyOwner {
        targetAddress = _addr;
        targetContract = TargetInterface(_addr);
    }

    // toggle sale, round
    function toggleSale() external onlyOwner {
        mintEnabled = !mintEnabled;
    }
    function toggleRound() external onlyOwner {
        wlRound = !wlRound;
    }

    // merkle tree
    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }
    function verifyAddress(bytes32[] calldata _merkleProof) private view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        return MerkleProof.verify(_merkleProof, merkleRoot, leaf);
    }

    // mint
    function mint(uint quantity, bytes32[] calldata _merkleProof) external {
        require(mintEnabled, "Sale is not enabled");
        if (wlRound) require(verifyAddress(_merkleProof), "Invalid Proof");
        
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
