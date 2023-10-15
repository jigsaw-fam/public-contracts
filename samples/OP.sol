/**
 * @dev The Optimism token used in governance and supporting voting and delegation.
 * Implements EIP 2612 allowing signed approvals.
 * Contract is "owned" by a `MintManager` instance with permission to the `mint` function only,
 * for the purposes of enforcing the token inflation schedule.
 */
contract GovernanceToken is ERC20Burnable, ERC20Votes, Ownable {
    /**
     * @dev Constructor.
     */
    constructor() ERC20("Optimism", "OP") ERC20Permit("Optimism") {}

    function mint(address _account, uint256 _amount) public onlyOwner {
        _mint(_account, _amount);
    }

    // The following functions are overrides required by Solidity.
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }
}
