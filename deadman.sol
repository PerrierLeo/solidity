// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;
import "hardhat/console.sol";

contract Switch {
    address private owner;
    address private recipient;
    uint private activity;

    constructor(address _recipient) payable {
        owner = msg.sender;
        recipient = _recipient;
        activity = block.timestamp;
    }

    function withdraw() external {
        uint delay = block.timestamp - activity;
        require(delay > 52 weeks, "to late");
        (bool s, ) = recipient.call{value: address(this).balance}("");
        require(s);
        activity = block.timestamp;
    }

    function ping() external {
        require(msg.sender == owner);
        activity = block.timestamp;
    }
}
