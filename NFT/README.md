# NFT Project: Create and Mint Your Own NFT

This project demonstrates how to create, deploy, and mint your own NFT (Non-Fungible Token) on the Ethereum Sepolia testnet using Hardhat, Ethers.js, and OpenZeppelin contracts.

## Prerequisites

- [Node.js](https://nodejs.org/en/) (v14 or higher)
- [npm](https://www.npmjs.com/)
- [Metamask](https://metamask.io/) wallet (with Sepolia Test Network enabled)
- [Alchemy](https://alchemy.com/) account (for Sepolia API key)

## Setup Instructions
1. **Install Dependencies**
   ```shell
   npm install
   ```

2. **Configure Environment Variables**
   - Create a `.env` file in the `NFT` directory with the following content:
     ```env
     API_URL = "https://eth-sepolia.g.alchemy.com/v2/your-api-key"
     PRIVATE_KEY = "your-metamask-private-key"
     API_KEY = "your-alchemy-api-key"
     ```
   - Replace the placeholders with your actual Alchemy API key and Metamask private key.

3. **Check Hardhat Configuration**
   - Ensure `hardhat.config.js` is set up for Sepolia and uses your `.env` variables.

## 1. Create and Deploy the NFT Smart Contract

1. **Write the Contract**
   - The contract is located at `contracts/MyNFT.sol` and uses OpenZeppelin's ERC721 implementation.

2. **Compile the Contract**
   ```shell
   npx hardhat compile
   ```

3. **Deploy the Contract to Sepolia**
   ```shell
   npx hardhat run scripts/deploy.js --network sepolia
   ```
   - Note the contract address output after deployment.

## 2. Mint an NFT

1. **Prepare NFT Metadata**
   - Create a file named `nft-metadata.json` in the `NFT` directory. Example:
     ```json
     {
    "attributes": [
        {
            "trait_type": "Event",
            "value": "Ship_It_On_Story"
        },
        {
            "trait_type": "City",
            "value": "Nagpur"
        }
    ],
    "description": "This was an event by CentralDAO in Nagpur",
    "image": "https://gateway.pinata.cloud/ipfs/bafybeib2c52isjla2vwdbqicqmbhiklp7v3ih5hwiswqkosrpndcxlcgy4",
    "name": "Tushar"
}
     ```
   - Upload your image and metadata JSON to [Pinata](https://pinata.cloud/) or another IPFS service. Copy the resulting IPFS hash for the metadata.

2. **Update the Mint Script**
   - In `scripts/mint-nft.js`, set the `tokenUri` variable to your metadata's IPFS gateway URL (e.g., `https://gateway.pinata.cloud/ipfs/<metadata-hash>`).
   - Ensure the contract address matches your deployed contract.

3. **Mint the NFT**
   ```shell
   node scripts/mint-nft.js
   ```
   - On success, the script will output a transaction link to Etherscan.

## 3. View Your NFT

- You can view your NFT on [Sepolia Etherscan](https://sepolia.etherscan.io/) using the transaction hash.
- To see your NFT in a wallet or on OpenSea, use your contract address and the Sepolia network.

## Additional Resources
- [Create_NFT.md](./Create_NFT.md): Full guide to contract creation and deployment.
- [Mint_NFT.md](./Mint_NFT.md): Full guide to minting NFTs and working with metadata.
- [Alchemy NFT Tutorials](https://docs.alchemy.com/alchemy/tutorials/how-to-write-and-deploy-a-nft-smart-contract)

---

**Happy minting!**
