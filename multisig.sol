// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract MultiSig {
    address[] public owners;
    uint public required;
    uint public transactionCount;
    mapping(uint => Transaction) public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    struct Transaction {
        address destination;
        uint value;
        bool executed;
        bytes data;
    }

    function executeTransaction(uint transactionId) public {
        Transaction storage transaction = transactions[transactionId];
        (bool s, ) = transaction.destination.call{value: transaction.value}(
            transaction.data
        );
        require(s);
        transaction.executed = true;
    }

    constructor(address[] memory _owners, uint _confirmations) {
        require(_owners.length > 0);
        require(_confirmations > 0);
        require(_confirmations <= _owners.length);
        owners = _owners;
        required = _confirmations;
    }

    function addTransaction(
        address destination,
        uint value,
        bytes memory data
    ) internal returns (uint transactionId) {
        transactionId = transactionCount;
        transactions[transactionId] = Transaction(
            destination,
            value,
            false,
            data
        );
        transactionCount += 1;
    }

    function isOwner(address _x) private view returns (bool) {
        for (uint i = 0; i < owners.length; i++) {
            if (_x == owners[i]) {
                return true;
            }
        }
        return false;
    }

    function submitTransaction(
        address destination,
        uint value,
        bytes memory data
    ) external {
        uint transactionId = addTransaction(destination, value, data);
        confirmTransaction(transactionId);
    }

    function confirmTransaction(uint transactionId) public {
        require(isOwner(msg.sender));
        confirmations[transactionId][msg.sender] = true;
        if (isConfirmed(transactionId)) {
            executeTransaction(transactionId);
        }
    }

    function getConfirmationsCount(
        uint transactionId
    ) public view returns (uint256 confirmationCount) {
        for (uint i = 0; i < owners.length; i++) {
            if (confirmations[transactionId][owners[i]] == true)
                confirmationCount++;
        }
    }

    function isConfirmed(uint transactionId) public view returns (bool) {
        return getConfirmationsCount(transactionId) >= required;
    }

    receive() external payable {}
}
