// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract Party {
    uint256 private amount;
    address[] participants;
    mapping(address => bool) public payed;

    constructor(uint participation) {
        amount = participation;
    }

    function rsvp() external payable {
        require(!payed[msg.sender], "already in");
        require(msg.value == amount, "not the right price");
        participants.push(msg.sender);
        payed[msg.sender] = true;
    }

    function payBill(address venue, uint totalCost) external payable {
        require(address(this).balance >= totalCost);
        (bool s, ) = venue.call{value: totalCost}("");
        require(s);
        uint amountForEach = address(this).balance / participants.length;
        for (uint i = 0; i < participants.length; i++) {
            (bool success, ) = participants[i].call{value: amountForEach}("");
            require(success);
        }
    }
}
