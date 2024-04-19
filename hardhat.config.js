require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24", // Or any other version
  networks: {
    amoy: {
      url: "https://polygon-amoy.g.alchemy.com/v2/OKtjM4rfdsrHwOqoFCKruQUWhWnxispg",
      chainId: 80002,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};