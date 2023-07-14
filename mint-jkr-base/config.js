// chain
const CHAIN_NAME      = "Base Mainnet";
const CHAIN_RPC       = "https://developer-access-mainnet.base.org";
const CHAIN_ID        = 8453;
const CHAIN_SYMBOL    = "ETH";
const CHAIN_EXPLORER  = "https://basescan.org";

// contract
const MAX_SUPPLY      = 10_000;
const MINT_PER_WALLET = 10;
const CONTRACT_ADDR   = "0x9496E312C3b5B972396F05c206d6F8775E0BFE46";
const CONTRACT_ABI    = [{"type":"constructor","inputs":[],"stateMutability":"nonpayable"},{"name":"AccountBalanceOverflow","type":"error","inputs":[]},{"name":"BalanceQueryForZeroAddress","type":"error","inputs":[]},{"name":"ContractsCannotMint","type":"error","inputs":[]},{"name":"MustMintAtLeastOneToken","type":"error","inputs":[]},{"name":"NotEnoughAvailableTokens","type":"error","inputs":[]},{"name":"NotOwnerNorApproved","type":"error","inputs":[]},{"name":"TokenAlreadyExists","type":"error","inputs":[]},{"name":"TokenDoesNotExist","type":"error","inputs":[]},{"name":"TransferFromIncorrectOwner","type":"error","inputs":[]},{"name":"TransferToNonERC721ReceiverImplementer","type":"error","inputs":[]},{"name":"TransferToZeroAddress","type":"error","inputs":[]},{"name":"Approval","type":"event","inputs":[{"name":"owner","type":"address","indexed":true,"internalType":"address"},{"name":"account","type":"address","indexed":true,"internalType":"address"},{"name":"id","type":"uint256","indexed":true,"internalType":"uint256"}],"anonymous":false,"signature":"0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925"},{"name":"ApprovalForAll","type":"event","inputs":[{"name":"owner","type":"address","indexed":true,"internalType":"address"},{"name":"operator","type":"address","indexed":true,"internalType":"address"},{"name":"isApproved","type":"bool","indexed":false,"internalType":"bool"}],"anonymous":false,"signature":"0x17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31"},{"name":"OwnershipTransferred","type":"event","inputs":[{"name":"previousOwner","type":"address","indexed":true,"internalType":"address"},{"name":"newOwner","type":"address","indexed":true,"internalType":"address"}],"anonymous":false,"signature":"0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0"},{"name":"Transfer","type":"event","inputs":[{"name":"from","type":"address","indexed":true,"internalType":"address"},{"name":"to","type":"address","indexed":true,"internalType":"address"},{"name":"id","type":"uint256","indexed":true,"internalType":"uint256"}],"anonymous":false,"signature":"0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"},{"name":"MAX_MINT_PER_WALLET","type":"function","inputs":[],"outputs":[{"name":"","type":"uint256","value":"10","internalType":"uint256"}],"constant":true,"signature":"0xb19960e6","stateMutability":"view"},{"name":"adminMint","type":"function","inputs":[{"name":"quantity","type":"uint256","internalType":"uint256"}],"outputs":[],"signature":"0xc1f26123","stateMutability":"nonpayable"},{"name":"approve","type":"function","inputs":[{"name":"account","type":"address","internalType":"address"},{"name":"id","type":"uint256","internalType":"uint256"}],"outputs":[],"payable":true,"signature":"0x095ea7b3","stateMutability":"payable"},{"name":"balanceOf","type":"function","inputs":[{"name":"owner","type":"address","internalType":"address"}],"outputs":[{"name":"result","type":"uint256","internalType":"uint256"}],"constant":true,"signature":"0x70a08231","stateMutability":"view"},{"name":"getApproved","type":"function","inputs":[{"name":"id","type":"uint256","internalType":"uint256"}],"outputs":[{"name":"result","type":"address","internalType":"address"}],"constant":true,"signature":"0x081812fc","stateMutability":"view"},{"name":"isApprovedForAll","type":"function","inputs":[{"name":"owner","type":"address","internalType":"address"},{"name":"operator","type":"address","internalType":"address"}],"outputs":[{"name":"result","type":"bool","internalType":"bool"}],"constant":true,"signature":"0xe985e9c5","stateMutability":"view"},{"name":"maxSupply","type":"function","inputs":[],"outputs":[{"name":"","type":"uint256","value":"10000","internalType":"uint256"}],"constant":true,"signature":"0xd5abeb01","stateMutability":"view"},{"name":"mint","type":"function","inputs":[{"name":"quantity","type":"uint256","internalType":"uint256"}],"outputs":[],"signature":"0xa0712d68","stateMutability":"nonpayable"},{"name":"mintEnabled","type":"function","inputs":[],"outputs":[{"name":"","type":"bool","value":false,"internalType":"bool"}],"constant":true,"signature":"0xd1239730","stateMutability":"view"},{"name":"name","type":"function","inputs":[],"outputs":[{"name":"","type":"string","value":"Jai Kae Rae","internalType":"string"}],"constant":true,"signature":"0x06fdde03","stateMutability":"view"},{"name":"numberMinted","type":"function","inputs":[{"name":"minter","type":"address","internalType":"address"}],"outputs":[{"name":"","type":"uint32","internalType":"uint32"}],"constant":true,"signature":"0xdc33e681","stateMutability":"view"},{"name":"owner","type":"function","inputs":[],"outputs":[{"name":"","type":"address","value":"0xf705Cb1501D04462aB7FF142F1F0ad198175725e","internalType":"address"}],"constant":true,"signature":"0x8da5cb5b","stateMutability":"view"},{"name":"ownerOf","type":"function","inputs":[{"name":"id","type":"uint256","internalType":"uint256"}],"outputs":[{"name":"result","type":"address","internalType":"address"}],"constant":true,"signature":"0x6352211e","stateMutability":"view"},{"name":"remainingSupply","type":"function","inputs":[],"outputs":[{"name":"","type":"uint256","value":"10000","internalType":"uint256"}],"constant":true,"signature":"0xda0239a6","stateMutability":"view"},{"name":"renounceOwnership","type":"function","inputs":[],"outputs":[],"signature":"0x715018a6","stateMutability":"nonpayable"},{"name":"safeTransferFrom","type":"function","inputs":[{"name":"from","type":"address","internalType":"address"},{"name":"to","type":"address","internalType":"address"},{"name":"id","type":"uint256","internalType":"uint256"}],"outputs":[],"payable":true,"signature":"0x42842e0e","stateMutability":"payable"},{"name":"safeTransferFrom","type":"function","inputs":[{"name":"from","type":"address","internalType":"address"},{"name":"to","type":"address","internalType":"address"},{"name":"id","type":"uint256","internalType":"uint256"},{"name":"data","type":"bytes","internalType":"bytes"}],"outputs":[],"payable":true,"signature":"0xb88d4fde","stateMutability":"payable"},{"name":"setApprovalForAll","type":"function","inputs":[{"name":"operator","type":"address","internalType":"address"},{"name":"isApproved","type":"bool","internalType":"bool"}],"outputs":[],"signature":"0xa22cb465","stateMutability":"nonpayable"},{"name":"setBaseURI","type":"function","inputs":[{"name":"_newBaseURI","type":"string","internalType":"string"}],"outputs":[],"signature":"0x55f804b3","stateMutability":"nonpayable"},{"name":"supportsInterface","type":"function","inputs":[{"name":"interfaceId","type":"bytes4","internalType":"bytes4"}],"outputs":[{"name":"result","type":"bool","internalType":"bool"}],"constant":true,"signature":"0x01ffc9a7","stateMutability":"view"},{"name":"symbol","type":"function","inputs":[],"outputs":[{"name":"","type":"string","value":"JKR","internalType":"string"}],"constant":true,"signature":"0x95d89b41","stateMutability":"view"},{"name":"toggleSale","type":"function","inputs":[],"outputs":[],"signature":"0x7d8966e4","stateMutability":"nonpayable"},{"name":"tokenURI","type":"function","inputs":[{"name":"tokenId","type":"uint256","internalType":"uint256"}],"outputs":[{"name":"","type":"string","internalType":"string"}],"constant":true,"signature":"0xc87b56dd","stateMutability":"view"},{"name":"totalSupply","type":"function","inputs":[],"outputs":[{"name":"","type":"uint256","value":"0","internalType":"uint256"}],"constant":true,"signature":"0x18160ddd","stateMutability":"view"},{"name":"transferFrom","type":"function","inputs":[{"name":"from","type":"address","internalType":"address"},{"name":"to","type":"address","internalType":"address"},{"name":"id","type":"uint256","internalType":"uint256"}],"outputs":[],"payable":true,"signature":"0x23b872dd","stateMutability":"payable"},{"name":"transferOwnership","type":"function","inputs":[{"name":"newOwner","type":"address","internalType":"address"}],"outputs":[],"signature":"0xf2fde38b","stateMutability":"nonpayable"},{"name":"withdraw","type":"function","inputs":[],"outputs":[],"signature":"0x3ccfd60b","stateMutability":"nonpayable"}];
