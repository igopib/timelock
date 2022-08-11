// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TimeLock {
    // mapping tracks the user to their amount of ether deposited
    mapping(address => uint) public balances;

    // mapping tracks the time when locked funds can be withdrawn
    mapping(address => uint) public lockTime;

    // function to deposit ether

    function deposit() external payable {
        // updates the balance
        balances[msg.sender] += msg.value;

        // updates the lockTime
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    // gets the balance associated to the address
    function getBalances() public view returns (uint) {
        uint bal = balances[msg.sender] / 1 ether;
        return bal;
    }

    function withdraw() public {
        // checks if msg.sender has depositied ether in the contract
        require(balances[msg.sender] > 0, "Insufficient balance!");

        // compares current block time to mapping lockTime to confirm if the lock has expired yet.
        require(
            block.timestamp > lockTime[msg.sender],
            "Lock has not yet expired!"
        );

        // updating balances
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        // sending ether back to user
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send ether");
    }
}
