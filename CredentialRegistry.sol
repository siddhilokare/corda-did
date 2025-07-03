// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CredentialRegistry {
    struct Credential {
        address issuer;
        address holder;
        bytes32 credentialHash;
        bool revoked;
        uint256 issuedAt;
        uint256 revokedAt;
    }
    
    mapping(bytes32 => Credential) public credentials;
    mapping(address => bytes32[]) public holderCredentials;
    
    event CredentialIssued(bytes32 indexed credentialId, address indexed issuer, address indexed holder);
    event CredentialRevoked(bytes32 indexed credentialId);
    
    function issueCredential(
        address holder,
        bytes32 credentialHash
    ) public returns (bytes32) {
        bytes32 credentialId = keccak256(abi.encodePacked(msg.sender, holder, credentialHash, block.timestamp));
        
        credentials[credentialId] = Credential({
            issuer: msg.sender,
            holder: holder,
            credentialHash: credentialHash,
            revoked: false,
            issuedAt: block.timestamp,
            revokedAt: 0
        });
        
        holderCredentials[holder].push(credentialId);
        
        emit CredentialIssued(credentialId, msg.sender, holder);
        return credentialId;
    }
    
    function revokeCredential(bytes32 credentialId) public {
        require(credentials[credentialId].issuer == msg.sender, "Only issuer can revoke");
        require(!credentials[credentialId].revoked, "Credential already revoked");
        
        credentials[credentialId].revoked = true;
        credentials[credentialId].revokedAt = block.timestamp;
        
        emit CredentialRevoked(credentialId);
    }
    
    function verifyCredential(bytes32 credentialId) public view returns (bool) {
        return credentials[credentialId].issuer != address(0) && !credentials[credentialId].revoked;
    }
}
