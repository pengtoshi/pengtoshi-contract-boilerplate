import { HardhatUserConfig } from "hardhat/config";
import "@openzeppelin/hardhat-upgrades";
import "@typechain/hardhat";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "hardhat-deploy";

const { NETWORK, DEVELOPER_ACCOUNT, DEVELOPER_PRIVATE_KEY, CHAIN_ID, PROVIDER_URL, GAS_PRICE } = process.env;

const getDeployPath = (): string => {
  return `./scripts/deploy/${NETWORK}/todo`;
};

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.27",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  networks: {
    hardhat: {
      chainId: 1337,
    },
    base_sepolia: {
      url: PROVIDER_URL || "",
      chainId: +(CHAIN_ID || 0),
      from: DEVELOPER_ACCOUNT || "",
      accounts: [DEVELOPER_PRIVATE_KEY || "0"],
    },
    // NOTE: Add other networks here
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  paths: {
    sources: "./contracts",
    cache: "./cache",
    artifacts: "./artifacts",
    deploy: getDeployPath(),
  },
};

export default config;
