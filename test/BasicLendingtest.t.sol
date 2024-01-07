// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/Lending.sol"; // Update the path to your Lending contract

contract LendingTest is Test {
    Lending lending;
    address user;

    function setUp() public {
        lending = new Lending();
        user = address(this);
        vm.deal(user, 10 ether); // Provide the test contract with 10 ether
    }

    function testDeposit() public {
        // Arrange
        uint256 depositAmount = 1 ether;

        // Act
        lending.deposit{value: depositAmount}();

        // Assert
        assertEq(lending.balances(user), depositAmount, "Balance should be updated after deposit");
        assertEq(lending.totalEthInContract(), depositAmount, "Total ETH in contract should be updated after deposit");
    }

    function testWithdraw() public {
        // Arrange
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 0.5 ether;
        lending.deposit{value: depositAmount}();

        // Act
        lending.withdraw(withdrawAmount);

        // Assert
        assertEq(lending.balances(user), depositAmount - withdrawAmount, "Balance should be updated after withdrawal");
        assertEq(lending.totalEthInContract(), depositAmount - withdrawAmount, "Total ETH in contract should be updated after withdrawal");
    }

    function testBorrow() public {
        // Arrange
        uint256 depositAmount = 5 ether;
        uint256 borrowAmount = 1 ether;
        lending.deposit{value: depositAmount}();

        // Act
        lending.borrow(borrowAmount);

        // Assert
        assertEq(lending.borrowed(user), borrowAmount, "Borrowed amount should be recorded correctly");
        assertEq(lending.totalEthInContract(), depositAmount - borrowAmount, "Total ETH in contract should decrease after borrowing");
    }

    function testRepay() public {
        // Arrange
        uint256 depositAmount = 5 ether;
        uint256 borrowAmount = 1 ether;
        uint256 repayAmount = 1 ether;
        lending.deposit{value: depositAmount}();
        lending.borrow(borrowAmount);

        // Act
        lending.repay{value: repayAmount}();

        // Assert
        assertEq(lending.borrowed(user), 0, "Borrowed amount should be zero after repayment");
        assertEq(lending.totalEthInContract(), depositAmount, "Total ETH in contract should be restored after repayment");
    }

    function testFailWithdrawMoreThanBalance() public {
        // Arrange
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 2 ether;
        lending.deposit{value: depositAmount}();

        // Act & Assert
        vm.expectRevert("Insufficient balance to withdraw");
        lending.withdraw(withdrawAmount);
    }

    function testFailBorrowMoreThanAvailable() public {
        // Arrange
        uint256 depositAmount = 1 ether;
        uint256 borrowAmount = 2 ether;
        lending.deposit{value: depositAmount}();

        // Act & Assert
        vm.expectRevert("Insufficient funds in contract");
        lending.borrow(borrowAmount);
    }

    function testFailRepayMoreThanBorrowed() public {
        // Arrange
        uint256 depositAmount = 5 ether;
        uint256 borrowAmount = 1 ether;
        uint256 repayAmount = 2 ether;
        lending.deposit{value: depositAmount}();
        lending.borrow(borrowAmount);

        // Act & Assert
        vm.expectRevert("Repaying more than borrowed");
        lending.repay{value: repayAmount}();
    }
}
