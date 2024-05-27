// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Contract {
    enum Choices {
        Yes,
        No
    }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    Vote none = Vote(Choices(0), address(0));

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender), "already vote");
        votes.push(Vote(choice, msg.sender));
    }

    function findVote(address x) internal view returns (Vote storage) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == x) {
                return votes[i];
            }
        }
        return none;
    }

    function hasVoted(address x) public view returns (bool) {
        return findVote(x).voter == x;
    }

    function findChoice(address voter) external view returns (Choices) {
        return findVote(voter).choice;
    }

    function changeVote(Choices choice) external {
        Vote storage vote = findVote(msg.sender);
        require(vote.voter == msg.sender);
        vote.choice = choice;
    }
}
