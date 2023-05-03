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

    // Événements
    
    event VoterRegistered(address voterAddress);
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted (address voter, uint proposalId);

    // Variables d'état

    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    WorkflowStatus public currentWorkflowStatus;
    address public admin;

    // Modificateurs

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function.");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "You are not registered to vote.");
        _;
    }

    modifier onlyDuringVotingSession() {
        require(currentWorkflowStatus == WorkflowStatus.VotingSessionStarted, "The voting session is not active.");
        _;
    }

    modifier onlyAfterVotingSessionEnded() {
        require(currentWorkflowStatus == WorkflowStatus.VotingSessionEnded, "The voting session is still active.");
        _;
    }

    modifier onlyAfterProposalsRegistrationEnded() {
        require(currentWorkflowStatus == WorkflowStatus.ProposalsRegistrationEnded, "Proposals registration is still active.");
        _;
    }

    // Fonctions d'administration

    function registerVoters(address[] memory _voters) public onlyAdmin {
        require(currentWorkflowStatus == WorkflowStatus.RegisteringVoters, "Cannot register voters at this time.");
        for (uint i = 0; i < _voters.length; i++) {
            require(!voters[_voters[i]].isRegistered, "Voter already registered.");
            voters[_voters[i]].isRegistered = true;
            emit VoterRegistered(_voters[i]);
        }
    }

    function startProposalsRegistration() public onlyAdmin {
        require(currentWorkflowStatus == WorkflowStatus.RegisteringVoters, "Cannot start proposals registration at this time.");
        currentWorkflowStatus = WorkflowStatus.ProposalsRegistrationStarted;
        emit WorkflowStatusChange(WorkflowStatus.RegisteringVoters, currentWorkflowStatus);
    }

    function endProposalsRegistration() public onlyAdmin {
        require(currentWorkflowStatus == WorkflowStatus.ProposalsRegistrationStarted, "Cannot end proposals registration at this time.");
        currentWorkflowStatus = WorkflowStatus.ProposalsRegistrationEnded;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationStarted, currentWorkflowStatus);
    }

    function startVotingSession() public onlyAdmin {
        require(currentWorkflowStatus == WorkflowStatus.ProposalsRegistrationEnded, "Cannot start voting session at this time.");
        currentWorkflowStatus = WorkflowStatus.VotingSessionStarted;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationEnded, currentWorkflowStatus);
    }

    function endVotingSession() public onlyAdmin {
        require(currentWorkflowStatus == WorkflowStatus.VotingSessionStarted, "Cannot end voting session at this time.");
        currentWorkflowStatus = WorkflowStatus.VotingSessionEnded;
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionStarted, currentWorkflowStatus);
    }

}