# corda-did
Decentralized Identity & Credential Registry
A prototype DApp for managing decentralized identities (DIDs) and issuing/verifying Verifiable Credentials (VCs) using Ethereum smart contracts and MetaMask.

Getting Started
Prerequisites
Make sure you have:

MetaMask browser extension installed

Node.js and npm (if running locally with http-server or similar)

Remix IDE or Ganache for contract deployment (optional for testing)

A modern browser (Chrome recommended)

Project Structure
bash
Copy
Edit
/index.html            # Frontend DApp (HTML + JS)
/abis/                 # ABI JSON files (optional for dynamic loading)
/contracts/            # Solidity smart contracts
  ├── DIDRegistry.sol
  └── CredentialRegistry.sol
/scripts/              # (Optional) JavaScript logic file
  └── app.js
Deployment Instructions
Option A: Run Locally
Clone or download this repository

bash
Copy
Edit
git clone https://github.com/siddhilokare/corda-did.git
cd did-credential-registry
Deploy contracts using Remix IDE:

Open Remix

Paste DIDRegistry.sol and CredentialRegistry.sol into separate files

Compile both using Solidity ^0.8.x

Deploy them separately using the Injected Web3 environment (ensure MetaMask is connected)

Copy the deployed contract addresses

Update the frontend with contract addresses

In /index.html or your script file, update:

js
Copy
Edit
const DID_REGISTRY_ADDRESS = "0xYourDIDRegistryAddress";
const CREDENTIAL_REGISTRY_ADDRESS = "0xYourCredentialRegistryAddress";
Serve the frontend locally
You can use a simple static server like http-server:

bash
Copy
Edit
npm install -g http-server
http-server .
Open the application
Go to http://localhost:8080 or the URL printed in your terminal.

MetaMask Wallet Setup
The application supports 3 distinct roles:

Role	Password	Example Ethereum Address
User	user123	0xc9F89D...
Issuer	issuer123	0x49cc22...
Verifier	verifier123	0x5B38Da...

Ensure your MetaMask account matches the role you're logging in as.

Features
User

Register a DID document (stored on-chain)

Lookup a DID by address

Issuer

Issue a credential by providing a hash of the content

Revoke credentials by ID

Verifier

Verify if a credential exists and whether it has been revoked

Hashing Credential Content
To create a credential hash using JavaScript:

js
Copy
Edit
ethers.utils.keccak256(ethers.utils.toUtf8Bytes("Transcript: GPA 9.5"))
Or in Remix Solidity console:

solidity
Copy
Edit
keccak256(abi.encodePacked("Transcript: GPA 9.5"))
Smart Contracts Overview
DIDRegistry.sol
createDID(string didDoc): Register a DID document

getDID(address): Retrieve DID document by address

CredentialRegistry.sol
issueCredential(address holder, bytes32 hash): Issue a new credential

revokeCredential(bytes32 id): Revoke an existing credential

verifyCredential(bytes32 id): Check if credential is valid and not revoked

Data and Code Availability
All smart contracts and frontend code are open-source and included in this repository. No private data is stored or transmitted.
