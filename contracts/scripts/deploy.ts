import { ethers, upgrades } from "hardhat";

async function main() {
  console.log("main")
  const Web3Honey = await ethers.getContractFactory("Web3Honey");
  console.log(Web3Honey);
  const web3Honey = await upgrades.deployProxy(Web3Honey);
  console.log("Deploying...: ", web3Honey.address);
  await web3Honey.deployed();
  console.log("Contract was deployed to :", web3Honey.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

console.log("start")
main();
