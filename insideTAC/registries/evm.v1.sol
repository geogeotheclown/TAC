// SPDX-License-Identifier: UNLICENSED
// TAC L5 Integrity Registry v0.4
pragma solidity ^0.8.20;

contract TACRegistryV1 {
    struct Compact {
        bytes32 compactRoot;
        address creator;
        uint256 createdAt;
        mapping(uint256 => bytes32) checkpoints; // timestamp => merkleRoot
        uint256 lastCheckpoint;
        address[] signers;
        mapping(address => bool) isSigner;
    }

    mapping(bytes32 => Compact) public compacts;

    event CompactCreated(bytes32 indexed id, bytes32 root, address creator);
    event CheckpointPosted(bytes32 indexed id, uint256 timestamp, bytes32 root, address poster);
    event SignerAdded(bytes32 indexed id, address signer);

    function createCompact(bytes32 _id, bytes32 _root, address[] calldata _signers) external {
        require(compacts[_id].createdAt == 0, "Exists");
        Compact storage c = compacts[_id];
        c.compactRoot = _root;
        c.creator = msg.sender;
        c.createdAt = block.timestamp;
        c.signers = _signers;
        for (uint i = 0; i < _signers.length; i++) {
            c.isSigner[_signers[i]] = true;
            emit SignerAdded(_id, _signers[i]);
        }
        emit CompactCreated(_id, _root, msg.sender);
    }

    function postCheckpoint(bytes32 _id, bytes32 _merkleRoot) external {
        Compact storage c = compacts[_id];
        require(c.createdAt > 0, "No compact");
        require(c.isSigner[msg.sender], "Not signer");
        require(block.timestamp >= c.lastCheckpoint + 60, "Too frequent"); // 1 min min
        c.checkpoints[block.timestamp] = _merkleRoot;
        c.lastCheckpoint = block.timestamp;
        emit CheckpointPosted(_id, block.timestamp, _merkleRoot, msg.sender);
    }

    function getCheckpoint(bytes32 _id, uint256 _timestamp) external view returns (bytes32) {
        return compacts[_id].checkpoints[_timestamp];
    }

    function verifyLog(
        bytes32 _id,
        uint256 _timestamp,
        bytes32 _leaf,
        bytes32[] calldata _proof
    ) external view returns (bool) {
        bytes32 root = compacts[_id].checkpoints[_timestamp];
        require(root!= 0, "No checkpoint");
        bytes32 computed = _leaf;
        for (uint i = 0; i < _proof.length; i++) {
            bytes32 p = _proof[i];
            if (computed <= p) {
                computed = keccak256(abi.encodePacked(computed, p));
            } else {
                computed = keccak256(abi.encodePacked(p, computed));
            }
        }
        return computed == root;
    }
}
