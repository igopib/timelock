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

    function getBalances() public view returns (uint) {
        uint bal = balances[msg.sender] / 1 ether;
        return bal;
    }
}
