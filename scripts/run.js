const { ethers } = require("hardhat");

async function main() {
  const timeLockFactory = await ethers.getContractFactory("TimeLock");
  console.log("Deploying Contract ...");

  const timeLock = await timeLockFactory.deploy();

  await timeLock.deployed();
  console.log(`Contract deployed to : ${timeLock.address}`);

  // Passing value in deposit function
  const passValue = { value: ethers.utils.parseEther("1") };
  const depositTxn = await timeLock.deposit(passValue);
  await depositTxn.wait(1);

  const balance = await timeLock.getBalances();

  console.log(`Your locked balance is : ${balance} ether`);

  // Testing withdraw function

  const withdrawTxn = await timeLock.withdraw();
  await withdrawTxn.wait(1);

  console.log("Withdrawing ether...");

  console.log(`Your locked balance is : ${balance} ether`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
