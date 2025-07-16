# Alchemy-Nagpur-Workshop

Welcome to the **Alchemy-Nagpur-Workshop** repository! This project contains everything you need to create, deploy, and mint your own NFTs (Non-Fungible Tokens) on the Ethereum Sepolia testnet, as well as example smart contracts for crowdfunding and basic funding.

## Directory Structure

```
Alchemy-Nagpur-Workshop/
├── CrowFunding.sol           # Example crowdfunding smart contract (Solidity)
├── FundMe.sol                # Example funding smart contract (Solidity)
├── NFT/                      # Main NFT project (see below)
│   ├── contracts/            # Solidity contracts (e.g., MyNFT.sol)
│   ├── scripts/              # Deployment and minting scripts
│   ├── test/                 # Hardhat test files
│   ├── nft-metadata.json     # Example NFT metadata
│   ├── hardhat.config.js     # Hardhat configuration
│   ├── package.json          # Project dependencies
│   ├── README.md             # Step-by-step NFT guide (see below)
│   └── ...                   # Other supporting files
├── public/                   # Images and screenshots for documentation
│   └── ...
├── README.md                 # (This file) Project overview
└── ...
```

## What You'll Find Here

- **NFT/**: The main directory for creating and minting NFTs. Includes smart contracts, deployment scripts, and a detailed [NFT/README.md](./NFT/README.md) with step-by-step instructions.
- **CrowFunding.sol & FundMe.sol**: Example Solidity contracts for learning and experimentation with crowdfunding and funding mechanisms.
- **public/**: Images and screenshots used in documentation and guides.

## Getting Started

### 1. NFT Project

If you want to create and mint your own NFT, follow the instructions in [NFT/README.md](./NFT/README.md). This guide covers:

- Prerequisites and setup
- Writing and deploying your NFT smart contract
- Minting NFTs with custom metadata
- Viewing your NFT on Etherscan and OpenSea

### 2. Example Smart Contracts

- `CrowFunding.sol` and `FundMe.sol` are standalone Solidity contracts. You can use them as learning resources or deploy them using your preferred Ethereum development environment (e.g., Hardhat, Remix).

## Prerequisites

- [Node.js](https://nodejs.org/en/) (v14 or higher)
- [npm](https://www.npmjs.com/)
- [Metamask](https://metamask.io/) wallet
- [Alchemy](https://alchemy.com/) account (for Sepolia API key)

## How to Use

1. **Clone the repository:**
   ```shell
   git clone https://github.com/tusharpamnani/Alchemy-Nagpur-Workshop
   cd Alchemy-Nagpur-Workshop
   ```
2. **NFT Project:**
   - Go to the `NFT` directory and follow the [NFT/README.md](./NFT/README.md).
3. **Other Contracts:**
   - Open `CrowFunding.sol` or `FundMe.sol` in your favorite Solidity IDE or deploy using Hardhat/Remix.

## Resources

- [NFT/README.md](./NFT/README.md): Full NFT creation and minting guide
- [Alchemy NFT Tutorials](https://docs.alchemy.com/alchemy/tutorials/how-to-write-and-deploy-a-nft-smart-contract)

---

**Happy building and minting!**
