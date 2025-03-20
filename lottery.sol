// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {

    // Array to store participants
    address[] public participants;

    // Function to enter the lottery
    function enter() public payable {
        // Minimum entry fee of 0.01 ether
        require(msg.value >= 0.01 ether, "Minimum entry fee is 0.01 ether");

        // Add the sender to the participants array
        participants.push(msg.sender);
    }

    // Function to select a random winner
    function selectWinner() public {
        // Ensure there are participants
        require(participants.length > 0, "No participants in the lottery");

        // Generate a random index to pick a winner
        uint index = random() % participants.length;

        // Get the winner's address
        address winner = participants[index];

        // Transfer the lottery pool to the winner
        payable(winner).transfer(address(this).balance);

        // Reset the participants for the next round
        participants = new address;
    }

    // Internal function to generate a pseudo-random number
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }
}
