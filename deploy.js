const hre = require("hardhat");

async function main() {
  // Aave V3 Pool Addresses Provider (Ethereum Mainnet)
  const POOL_ADDRESS_PROVIDER = "0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e";

  const flashLoan = await hre.ethers.deployContract("SimpleFlashLoan", [POOL_ADDRESS_PROVIDER]);
  await flashLoan.waitForDeployment();

  console.log("Flash Loan contract deployed to:", await flashLoan.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
