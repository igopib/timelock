const { ethers } = require("hardhat");

async function main() {
  const timeLockFactory = await ethers.getContractFactory("TimeLock");
  console.log("Deploying Contract ...");

  const timeLock = await timeLockFactory.deploy();

  await timeLock.deployed();
  console.log(`Contract deployed to : ${timeLock.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
