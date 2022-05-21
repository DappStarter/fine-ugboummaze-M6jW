require('@babel/register');
({
    ignore: /node_modules/
});
require('@babel/polyfill');

const HDWalletProvider = require('@truffle/hdwallet-provider');

let mnemonic = 'grid enter off foot filter raise saddle pumpkin hope armed off gesture'; 
let testAccounts = [
"0x32ee6d3716099a297ab9b38cba353f0bf5734387479971485df7d419a8650916",
"0xa9c402e1adfca64d80be7220ec1c248818c361aa092850afd1fc7f5414f9478e",
"0xd6baaf235a97a53d88a23c78efb1df4a133d073f8838a198a047bd19470eb80d",
"0xe9d86d28d5572f7c93ea9bcbafba94f6503b8affa4371764a70eba07ada50d6a",
"0xa6fd871d4729fb008d4302fcd41d13e8e2ecc3cc322b86a687fffb332edab77b",
"0x1130a432a5db436c9cb14cdb76751b7b020bc6a1a5ff309193f9ee7b1881b735",
"0xee2cb24b99e6afe701536981c09fc64f22a1ea87384df323420186c488938120",
"0xbaed4742114857be9600090afdcd63e4bf50393d526355274e47508271985569",
"0xed8754c47400d61f78cca10f31d6d7ec881849624af08ba2396b51848ba4a34e",
"0x6abc66c20f3e458cfde660c27d999d8b3b46a7e04dd505d36880d1c5315a7ad9"
]; 
let devUri = 'https://rpc-mumbai.matic.today';

module.exports = {
    testAccounts,
    mnemonic,
    networks: {
        development: {
            uri: devUri,
            provider: () => new HDWalletProvider(
                mnemonic,
                devUri, // provider url
                0, // address index
                10, // number of addresses
                true, // share nonce
                `m/44'/60'/0'/0/` // wallet HD path
            ),
            gas: 2000000,
            network_id: 80001,
            confirmations: 1,
            timeoutBlocks: 100,
            skipDryRun: true
        }
    },
    compilers: {
        solc: {
            version: '^0.5.11'
        }
    }
};

