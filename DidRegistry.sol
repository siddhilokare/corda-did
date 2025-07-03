// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DIDRegistry {
    mapping(address => string) public didDocuments;
    mapping(address => bool) public controllers;
    
    event DIDCreated(address indexed identityOwner, string didDocument);
    
    constructor() {
        controllers[msg.sender] = true;
    }
    
    function createDID(string memory didDocument) public {
        require(bytes(didDocument).length > 0, "DID document cannot be empty");
        didDocuments[msg.sender] = didDocument;
        emit DIDCreated(msg.sender, didDocument);
    }
    
    function getDID(address identityOwner) public view returns (string memory) {
        return didDocuments[identityOwner];
    }
}
