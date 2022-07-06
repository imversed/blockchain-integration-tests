const HDWalletProvider = require("@truffle/hdwallet-provider");

const mnemonic =
	"mouse public panel speak educate domain course object eternal sheriff angry stove blanket fence notice banner whale orbit ring census arctic suffer purity crisp";
module.exports = {
  contracts_build_directory: './build-ovm',  
    networks: {
      imversed: {
	provider: () =>
	   new HDWalletProvider(mnemonic, "http://127.0.0.1:8545"),
	network_id: 123,
	chain_id: 123,
	gas: 3000000000,
     },
   },

   // Set default mocha options here, use special reporters etc.
   mocha: {
     // timeout: 100000 	
   },

   // Configure your compilers
   compilers: {
     solc: {
      version: "0.8.13",
      settings: {
        optimizer:{
          enabled: true,
          runs: 1000
        },
        evmVersion:"homestead"
      },
      },
   },
};
