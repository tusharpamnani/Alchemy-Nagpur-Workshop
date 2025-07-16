// SPDX-License-Identifier: MIT
// License that allows reuse of this code with minimal restrictions.

pragma solidity ^0.8.20;
// Tells the compiler to use Solidity version 0.8.20 or newer (but not 0.9.0+)

// A simple crowdfunding smart contract
contract CrowdFund {
    // State variables
    address public owner;           // Address of the person who deployed the contract
    uint256 public goal;            // The fundraising goal (in wei)
    uint256 public deadline;        // Time until which funding is allowed (timestamp)
    uint256 public totalRaised;     // Total ETH raised by the campaign

    // Mapping to track how much each address has contributed
    mapping(address => uint256) public contributions;

    // Flags to track the campaign's status
    bool public goalReached;        // Set to true if goal is reached
    bool public withdrawn;          // Prevents the owner from withdrawing multiple times

    // Events help with tracking actions on the blockchain
    event Funded(address indexed contributor, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);
    event Refunded(address indexed contributor, uint256 amount);

    // Constructor is run once when contract is deployed
    constructor(uint256 _goal, uint256 _durationMinutes) {
        require(_goal > 0, "Goal must be > 0");                        // Ensure goal is positive
        require(_durationMinutes > 0, "Duration must be > 0");        // Ensure duration is positive

        owner = msg.sender;                                           // Set the deployer as the owner
        goal = _goal;                                                 // Set the fundraising goal
        deadline = block.timestamp + (_durationMinutes * 1 minutes); // Set the deadline using duration in minutes
    }

    // Modifier to allow only the owner to run certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Modifier to allow function only before the deadline
    modifier beforeDeadline() {
        require(block.timestamp <= deadline, "Past deadline");
        _;
    }

    // Modifier to allow function only after the deadline
    modifier afterDeadline() {
        require(block.timestamp > deadline, "Deadline not yet passed");
        _;
    }

    // Function to contribute ETH to the crowdfunding campaign
    function fund() external payable beforeDeadline {
        require(msg.value > 0, "Must send ETH");             // Contribution must be greater than zero
        contributions[msg.sender] += msg.value;              // Track how much sender contributed
        totalRaised += msg.value;                            // Update total raised amount

        // Check if goal is reached
        if (totalRaised >= goal) {
            goalReached = true;
        }

        emit Funded(msg.sender, msg.value);                  // Emit event for logging
    }

    // Allows owner to withdraw funds if goal is reached after the deadline
    function withdraw() external onlyOwner afterDeadline {
        require(goalReached, "Funding goal not met");        // Only withdraw if goal was met
        require(!withdrawn, "Already withdrawn");            // Prevent multiple withdrawals

        withdrawn = true;                                    // Mark as withdrawn
        payable(owner).transfer(address(this).balance);      // Send all ETH to the owner

        emit Withdrawn(owner, address(this).balance);        // Log withdrawal
    }

    // Allows contributors to get a refund if goal was not reached
    function refund() external afterDeadline {
        require(!goalReached, "Goal was reached");           // Refunds only allowed if goal failed

        uint256 amount = contributions[msg.sender];          // Check how much the sender contributed
        require(amount > 0, "No funds to refund");           // No refund if nothing was contributed

        contributions[msg.sender] = 0;                       // Reset contribution before sending back ETH
        payable(msg.sender).transfer(amount);                // Send refund

        emit Refunded(msg.sender, amount);                   // Log refund
    }

    // View how much time is left until the deadline (in seconds)
    function getTimeLeft() external view returns (uint256) {
        if (block.timestamp >= deadline) {
            return 0; // Deadline has passed
        } else {
            return deadline - block.timestamp; // Time remaining
        }
    }

    // View the current ETH balance held by the contract
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
