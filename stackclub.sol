// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract StackClub {
    address[] members;

    constructor() {
        members.push(msg.sender);
    }

    function addMember(address x) external {
        require(!isMember(x), "already in the club");
        members.push(x);
    }

    function isMember(address x) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == x) {
                return true;
            }
        }
        return false;
    }

    function removeLastMember() external {
        require(isMember(msg.sender), "not in the club");
        members.pop();
    }
}
