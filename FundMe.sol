// SPDX-License-Identifier: MIT
// This is a license identifier that tells others how they can use this code.
// MIT is a very permissive license, meaning anyone can use or modify it with minimal restrictions.

pragma solidity ^0.8.20;
// This line tells the compiler which version of Solidity to use. 
// In this case, it will only compile with version 0.8.20 or later (but not 0.9.0 or higher).

// Declare the smart contract
contract FundMe {
    // The address of the person who deployed the contract
    address public owner;

    // A mapping (like a dictionary) that keeps track of how much ETH each address has contributed
    mapping(address => uint256) public contributions;

    // The constructor function is run only once—when the contract is deployed
    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // A modifier is used to add conditions to functions.
    // This one restricts certain functions to be called only by the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _; // This means “continue executing the rest of the function”
    }

    // This function allows anyone to send ETH (Ether) to the contract
    // `external` means it can only be called from outside the contract
    // `payable` means the function can receive ETH
    function fund() external payable {
        require(msg.value > 0, "Must send some Ether"); // Make sure some ETH is sent
        contributions[msg.sender] += msg.value; // Add the sent ETH to the sender's total contribution
    }

    // A read-only function that returns the current balance of ETH held by the contract
    function getBalance() external view returns (uint256) {
        return address(this).balance; // Return the amount of ETH stored in the contract
    }

    // Allows only the owner to withdraw all ETH from the contract
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance; // Get the current balance
        require(balance > 0, "No funds to withdraw"); // Make sure there's something to withdraw
        payable(owner).transfer(balance); // Send the ETH to the owner's address
    }
}
