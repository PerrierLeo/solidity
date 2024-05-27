// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    bool public isApproved = false;

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    event Approved(uint);

    function approve() external {
        require(msg.sender == arbiter, "you don't have right");
        require(isApproved == false, "not approuved");
        uint balance = address(this).balance;
        (bool success, ) = beneficiary.call{value: balance}("doneee");
        require(success);
        emit Approved(balance);
        isApproved = true;
    }
}
