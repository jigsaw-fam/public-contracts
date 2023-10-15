// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// 1. setToken
// 2. setRecipients
// 3. toggleClaim
contract BoredTownTokenDistributor is Ownable {

    // events
    event CanClaim(address indexed recipient, uint256 amount);
    event HasClaimed(address indexed recipient, uint256 amount);
    event Withdrawal(address indexed recipient, uint256 amount);

    // token
    IERC20 public token;
    function setToken(address newToken) external onlyOwner {
        token = IERC20(newToken);
    }

    // update recipients
    mapping(address => uint256) public claimableTokens;
    uint256 public totalClaimable;
    function setRecipients(address[] calldata _recipients, uint256[] calldata _claimableAmount)
        external
        onlyOwner
    {
        require(
            _recipients.length == _claimableAmount.length, "invalid array length"
        );
        uint256 sum = totalClaimable;
        for (uint256 i = 0; i < _recipients.length; i++) {
            claimableTokens[_recipients[i]] = _claimableAmount[i];
            emit CanClaim(_recipients[i], _claimableAmount[i]);
            unchecked {
                sum += _claimableAmount[i];
            }
        }
        totalClaimable = sum;
    }
    function resetTotalClaimable() external onlyOwner {
        totalClaimable = 0;
    }

    // owner withdraw
    function withdraw(uint256 amount) public onlyOwner {
        require(token.transfer(msg.sender, amount), "fail transfer token");
        emit Withdrawal(msg.sender, amount);
    }

    // toggle round
    bool public claimEnabled = false;
    function toggleClaim() external onlyOwner {
        claimEnabled = !claimEnabled;
    }

    // claim token
    function claim() public {
        require(claimEnabled, "claim is not enabled");

        uint256 amount = claimableTokens[msg.sender];
        require(amount > 0, "nothing to claim");
        require(token.balanceOf(address(this)) >= amount, "not enough token");

        claimableTokens[msg.sender] = 0;

        // we don't use safeTransfer since impl is assumed to be OZ
        require(token.transfer(msg.sender, amount), "fail token transfer");
        emit HasClaimed(msg.sender, amount);
    }

}
