// https://docs.ethers.org/v6/getting-started/
let provider = null;
let signer = null;
let wallet = null;
let contract = null;
let reader = new ethers.Contract(CONTRACT_ADDR, CONTRACT_ABI, new ethers.JsonRpcProvider(CHAIN_RPC));

// main
update_supply();

// connect/disconnect buttons
$('#connect').click(async _ => {
  // connect metamask
  provider = new ethers.BrowserProvider(window.ethereum)
  signer = await provider.getSigner();

  // switch chain
  await switch_opbnb_chain();

  // show mint button
  $('#connect').addClass('d-none');
  $('#mint').removeClass('d-none');
  $('#disconnect')
    .text(`Disconnect ${short_addr(signer.address)}`)
    .removeClass('d-none');
});
$('#disconnect').click(_ => {
  $('#connect').removeClass('d-none');
  $('#mint').addClass('d-none');
  $('#minted').addClass('d-none');
  $('#disconnect').addClass('d-none');
});

// mint button
$('#mint').click(_ => {

  // TODO party effect
  play_party_effect();

});

/*
----- READ -----
// load contract info (await)
contract = new ethers.Contract(config.token_addr, CONTRACT_ABI, signer);
let dec = await contract.decimals();
let votes = await contract.getFunction('getVotes').staticCall(ZONIC_ADDR);
let delegated_addr = await contract.getFunction('delegates').staticCall(wallet);
let k_votes = parseInt(votes) / Math.pow(10, parseInt(dec)+3); // 1_000 -> 3
let token_balance = await contract.getFunction('balanceOf').staticCall(wallet);
token_balance = parseInt(token_balance) / Math.pow(10, parseInt(dec));
----- WRITE -----
$('.btn-delegate').click(e => {
  let target = e.target;
  if ($(target).hasClass('is-disabled')) return;
  $(target).addClass('is-disabled');
  contract.getFunction('delegate').send(ZONIC_ADDR)
    .then(_ => {
      $('.btn-delegate').html('Complete');
      alert('Delegate Success! Check your txn.')
    })
    .catch(e => {
      alert(e);
      $(target).removeClass('is-disabled');
    })
});
*/

// reconnect when switch account
window.ethereum.on('accountsChanged', function (accounts) {
  $('#disconnect').click();
  $('#connect').click();
});

// disconnect when switch chain
window.ethereum.on('chainChanged', function (networkId) {
  if (parseInt(networkId) == CHAIN_ID) return;
  $('#disconnect').click();
});

// web3 functions
function update_supply() {
  $('#supply').html('Supply: ...');
  reader.getFunction('remainingSupply').staticCall().then(remain => {
    $('#supply').html(`Supply: ${remain}/${MAX_SUPPLY}`);
  });
}
async function switch_opbnb_chain() {
  // https://docs.metamask.io/wallet/reference/wallet_addethereumchain/
  // https://ethereum.stackexchange.com/questions/134610/metamask-detectethereumprovider-check-is-connected-to-specific-chain
  let { chainId } = await provider.getNetwork();
  chainId = parseInt(chainId);
  if (chainId == CHAIN_ID) return;
  // switch chain
  try {
    await window.ethereum.request({
      "method": "wallet_switchEthereumChain",
      "params": [
        {
          "chainId": "0x" + CHAIN_ID.toString(16),
        }
      ]
    });
  }
  // if chain not found, add chain
  catch(switchError) {
    if (switchError.code == 4902) {
      await window.ethereum.request({
        "method": "wallet_addEthereumChain",
        "params": [
          {
            "chainId": "0x" + CHAIN_ID.toString(16),
            "chainName": CHAIN_NAME,
            "rpcUrls": [
              CHAIN_RPC,
            ],
            //"iconUrls": [
            //  "https://xdaichain.com/fake/example/url/xdai.svg",
            //  "https://xdaichain.com/fake/example/url/xdai.png"
            //],
            "nativeCurrency": {
              "name": CHAIN_SYMBOL,
              "symbol": CHAIN_SYMBOL,
              "decimals": 18
            },
            "blockExplorerUrls": [
              CHAIN_EXPLORER,
            ]
          }
        ]
      });
    }
    else {
      alert(switchError.message)
    }
  }
}

// common
function short_addr(addr) {
  return addr.substr(0, 5) + '...' + addr.slice(-4);
}
function play_party_effect() {
  party.confetti(document.body, {
      count: 120,
      size: 2,
  });
}
