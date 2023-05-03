// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable {

    // Structures de données
    
    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    
    struct Proposal {
        string description;
        uint voteCount;
    }

    // Énumération des états du processus de vote
    
    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }

    uint public winningProposalId;

}