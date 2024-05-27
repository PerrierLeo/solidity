//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract Contract {
    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    function tip() public payable {
        (bool s, ) = owner.call{value: msg.value}("");
        require(s);
    }

    function donate() external payable {
        selfdestruct(payable(charity));
    }

    receive() external payable {
        console.log(msg.sender);
    }
}

contract Contract {
    enum ConnectionTypes {
        Unacquainted,
        Friend,
        Family
    }

    mapping(address => mapping(address => ConnectionTypes)) public connections;

    function connectWith(
        address other,
        ConnectionTypes connectionType
    ) external {
        connections[msg.sender][other] = connectionType;
    }
}
