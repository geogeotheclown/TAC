
---

### **File 2: `insideTAC/slashers/evm.v1.sol`**
Create folder `insideTAC/slashers/` → new file `evm.v1.sol` → paste:

```solidity
// SPDX-License-Identifier: UNLICENSED
// TAC L4 Slasher Reference Implementation v0.2
// Public Domain 2026
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IOracle {
    function getVerdict(bytes32 compactId) external view returns (bool success, uint256 timestamp);
}

contract TACSlasherV1 is Ownable {
    struct Compact {
        address escrowToken; // USDC, etc
        address oracle;
        uint256 deadline;
        uint256 timelock; // seconds, default 24h
        address[] parties;
        mapping(address => uint256) stakes;
        mapping(address => uint8) violationType; // 0=none, 1=miss_deadline, 2=fraud, etc
        mapping(uint8 => address[]) payoutRecipients;
        mapping(uint8 => uint8[]) payoutShares; // basis points, sum=10000
        bool executed;
        bool disputed;
        uint256 fraudProofDeadline;
    }

    mapping(bytes32 => Compact) public compacts;
    uint256 public constant DISPUTE_WINDOW = 3 days;
    
    event CompactCreated(bytes32 indexed id, address indexed creator);
    event Staked(bytes32 indexed id, address indexed party, uint256 amount);
    event ViolationReported(bytes32 indexed id, uint8 violationType);
    event Slashed(bytes32 indexed id, address indexed violator, uint256 amount);
    event DisputeRaised(bytes32 indexed id, address indexed disputer);

    function createCompact(
        bytes32 _id,
        address _escrowToken,
        address _oracle,
        uint256 _deadline,
        address[] calldata _parties
    ) external {
        require(compacts[_id].deadline == 0, "Exists");
        Compact storage c = compacts[_id];
        c.escrowToken = _escrowToken;
        c.oracle = _oracle;
        c.deadline = _deadline;
        c.timelock = 24 hours;
        c.parties = _parties;
        emit CompactCreated(_id, msg.sender);
    }

    function stake(bytes32 _id, uint256 _amount) external {
        Compact storage c = compacts[_id];
        require(c.deadline > 0, "No compact");
        require(block.timestamp < c.deadline, "Expired");
        IERC20(c.escrowToken).transferFrom(msg.sender, address(this), _amount);
        c.stakes[msg.sender] += _amount;
        emit Staked(_id, msg.sender, _amount);
    }

    function setPenalty(
        bytes32 _id,
        uint8 _violationType,
        address[] calldata _recipients,
        uint8[] calldata _shares
    ) external onlyOwner {
        Compact storage c = compacts[_id];
        require(_recipients.length == _shares.length, "Mismatch");
        uint256 sum = 0;
        for (uint i = 0; i < _shares.length; i++) sum += _shares[i];
        require(sum == 10000, "Shares != 100%");
        c.payoutRecipients[_violationType] = _recipients;
        c.payoutShares[_violationType] = _shares;
    }

    function reportViolation(bytes32 _id, address _violator, uint8 _type) external {
        Compact storage c = compacts[_id];
        require(block.timestamp >= c.deadline, "Not expired");
        require(c.stakes[_violator] > 0, "No stake");
        (bool success, ) = IOracle(c.oracle).getVerdict(_id);
        require(success == false, "Oracle says success");
        c.violationType[_violator] = _type;
        c.fraudProofDeadline = block.timestamp + c.timelock;
        emit ViolationReported(_id, _type);
    }

    function executeSlash(bytes32 _id, address _violator) external {
        Compact storage c = compacts[_id];
        require(c.violationType[_violator] > 0, "No violation");
        require(block.timestamp >= c.fraudProofDeadline, "Timelock");
        require(!c.executed, "Already slashed");
        require(!c.disputed, "Disputed");
        
        uint256 amount = c.stakes[_violator];
        c.stakes[_violator] = 0;
        c.executed = true;

        address[] memory recips = c.payoutRecipients[c.violationType[_violator]];
        uint8[] memory shares = c.payoutShares[c.violationType[_violator]];
        
        for (uint i = 0; i < recips.length; i++) {
            uint256 payout = amount * shares[i] / 10000;
            IERC20(c.escrowToken).transfer(recips[i], payout);
        }
        emit Slashed(_id, _violator, amount);
    }

    function raiseDispute(bytes32 _id) external {
        Compact storage c = compacts[_id];
        require(c.fraudProofDeadline > 0, "No violation");
        require(block.timestamp <= c.fraudProofDeadline + DISPUTE_WINDOW, "Dispute expired");
        c.disputed = true;
        emit DisputeRaised(_id, msg.sender);
    }

    // Emergency: TAC multisig can resolve disputes. In v2 this goes to Kleros.
    function resolveDispute(bytes32 _id, bool _upholdSlash) external onlyOwner {
        Compact storage c = compacts[_id];
        require(c.disputed, "Not disputed");
        if (!_upholdSlash) {
            c.violationType[msg.sender] = 0; // clear violation
        }
        c.disputed = false;
    }
}
