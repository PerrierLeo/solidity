// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract Hackathon {
    struct Project {
        string title;
        uint[] ratings;
    }

    Project[] projects;

    function newProject(string calldata _title) external {
        // creates a new project with a title and an empty ratings array
        projects.push(Project(_title, new uint[](0)));
    }

    function rate(uint _idx, uint _rating) external {
        // rates a project by its index
        projects[_idx].ratings.push(_rating);
    }

    function findWinner() external view returns (Project memory) {
        Project memory winner;
        uint averageRating;

        if (projects.length == 1) return projects[0];

        console.log(projects.length);

        for (uint i = 0; i < projects.length; i++) {
            uint averageProject;

            for (uint j = 0; j < projects[i].ratings.length; j++) {
                averageProject += projects[i].ratings[j];
            }

            averageProject /= projects[i].ratings.length;

            if (averageProject > averageRating) {
                averageRating = averageProject;
                winner = projects[i];
            }
        }
        return winner;
    }
}
