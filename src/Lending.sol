// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Lending {
    // === STATE VARIABLES ===
    mapping(address => uint256) public balances;
    mapping(address => uint256) public borrowed;
    uint256 public totalEthInContract;

    // === EVENTS ===
    event UserHasDepositedEth(address user, uint256 amount);
    event UserHasWithdrawnEth(address user, uint256 amount);
    event UserHasBorrowedEth(address user, uint256 amount);
    event UserHasRepaidLoan(address user, uint256 amount);

    // Deposit Function: Implement a deposit function for users to add ETH.
    function deposit() public payable {
        require(msg.value > 0, "No Ether Transferred");
        balances[msg.sender] += msg.value;
        totalEthInContract += msg.value;
        emit UserHasDepositedEth(msg.sender, msg.value);
    }

    // Withdraw Function: Add a withdraw function for users to retrieve their ETH.
    function withdraw(uint256 amount) public {
        require(amount > 0, "Specify Amount to Withdraw");
        require(balances[msg.sender] >= amount, "Insufficient balance to withdraw");
        balances[msg.sender] -= amount;
        totalEthInContract -= amount;
        payable(msg.sender).transfer(amount);
        emit UserHasWithdrawnEth(msg.sender, amount);
    }

    // Borrow Function: Create a borrow function for users to take out loans.
    function borrow(uint256 amount) public {
        require(amount > 0, "Specify Amount to Borrow");
        require(totalEthInContract >= amount, "Insufficient funds in contract");
        borrowed[msg.sender] += amount;
        totalEthInContract -= amount;
        payable(msg.sender).transfer(amount);
        emit UserHasBorrowedEth(msg.sender, amount);
    }

    // Repay Function: Develop a repay function for users to return borrowed ETH.
    function repay() public payable {
        require(msg.value > 0, "No ether sent to repay debt");
        require(borrowed[msg.sender] >= msg.value, "Repaying more than borrowed");
        borrowed[msg.sender] -= msg.value;
        totalEthInContract += msg.value;
        emit UserHasRepaidLoan(msg.sender, msg.value);
    }


}


