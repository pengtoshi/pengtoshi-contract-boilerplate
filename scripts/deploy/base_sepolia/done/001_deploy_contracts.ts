import { ethers, upgrades } from "hardhat";
import { DeployFunction, DeploymentSubmission } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments } = hre;
  const { deploy, save } = deployments;
  const [developer] = await ethers.getSigners();

  const network = process.env.NETWORK;
  if (network !== "base_sepolia") {
    throw new Error(`😇 This script is only for base sepolia.`);
  }
  console.log("🪴 Deploy started with wallet: ", developer.address);

  const hello = await deploy("Hello", {
    from: developer.address,
    args: ["Pengtoshi Nakamoto"],
    log: true,
    autoMine: true,
  });

  console.log("🚀 Hello deployed at", hello.address);

  /*
      Using UUPS proxy with hardhat-deploy
      Since UUPS proxy is not supported by hardhat-deploy, we need to use the pattern below:
      https://github.com/wighawag/hardhat-deploy/issues/242#issuecomment-998790266
  */

  const HelloUpgradeableContract = await ethers.getContractFactory("HelloUpgradeable");
  const helloUpgradeable = await upgrades.deployProxy(HelloUpgradeableContract, ["Pengtoshi Nakamoto"], {
    kind: "uups",
  });
  console.log("🚀 HelloUpgradeable deployed at", helloUpgradeable.address);

  const artifact = await deployments.getExtendedArtifact("HelloUpgradeable");
  const proxyDeployments: DeploymentSubmission = {
    address: helloUpgradeable.address,
    ...artifact,
  };
  await save("HelloUpgradeable", proxyDeployments);
};

export default func;
func.tags = ["001_deploy_contracts"];
