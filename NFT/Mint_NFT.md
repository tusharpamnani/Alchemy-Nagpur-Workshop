## Creating the Mint NFT Script

### Step 1: Create an Alchemy Provider using ethers

Open the repository from Part 1 in your favorite code editor (e.g. VSCode), and create a new file in the `scripts` folder called `mint-nft.js`. We will be using the `ethers` library from Part 1 to connect to the Alchemy Provider. Add the following code to the file:

```javascript mint-nft.js
require("dotenv").config();
const ethers = require("ethers");

// Get Alchemy API Key
const API_KEY = process.env.API_KEY;

// Define an Alchemy Provider
const provider = new ethers.AlchemyProvider("sepolia", API_KEY);
```

Note that we are using `API_KEY` and not `API_URL`. Make sure you add this to your `.env` file so that it looks something like this:

```shell .env
API_URL = "https://eth-sepolia.g.alchemy.com/v2/your-api-key"
PRIVATE_KEY = "your-metamask-private-key"
API_KEY = "your-api-key"
```

### Step 2: Grab your contract ABI

The contract ABI (Application Binary Interface) is an interface to interact with our smart contract. You can learn more about Contract ABIs [here](https://docs.alchemyapi.io/alchemy/guides/eth_getlogs#what-are-ab-is). Hardhat automatically generates an ABI for us and saves it in the `MyNFT.json` file. In order to use this we'll need to parse out the contents by adding the following code to the `mint-nft.js` file:

```json mint-nft.js
const contract = require("../artifacts/contracts/MyNFT.sol/MyNFT.json");
```

If you want to see the ABI you can print it to your console:

```shell shell
console.log(JSON.stringify(contract.abi));
```

To run and see your ABI printed to the console navigate to your terminal and run

```shell shell
node scripts/mint-nft.js
```

### Step 3: Configure the metadata of your NFT using IPFS

Our `mintNFT` smart contract function takes in a `tokenURI` parameter that should resolve to a JSON document describing the NFT's metadata— which is really what brings the NFT to life, allowing it to have configurable properties, such as a name, description, image, and other attributes.

> Interplanetary File System (IPFS) is a decentralized protocol and peer-to-peer network for storing and sharing data in a distributed file system.

We will use [Pinata](https://pinata.cloud), a convenient IPFS API and toolkit, to store our NFT asset and metadata and ensure that our NFT is truly decentralized. If you don't have a Pinata account, sign up for a free account [here](https://pinata.cloud/signup).

Once you've created an account:

- Navigate to the _Pinata Upload_ button on the top right
- Upload an image to pinata - this will be the image asset for your NFT. Feel free to name the asset whatever you wish
- After you upload, at the top of the page, there should be a green popup that allows you to view the hash of your upload —> Copy that hashcode. You can view your upload at: [https://gateway.pinata.cloud/ipfs/\<image-hash-code>](https://gateway.pinata.cloud/ipfs/bafybeib2c52isjla2vwdbqicqmbhiklp7v3ih5hwiswqkosrpndcxlcgy4)

For the more visual learners, the steps above are summarized here: Now, we're going to want to upload one more document to Pinata. But before we do that, we need to create it!

![](https://files.buildwithfern.com/https://alchemy.docs.buildwithfern.com/docs/2025-07-16T20:14:47.594Z/tutorials/creating-smart-contracts/how-to-create-an-nft-on-ethereum-tutorial/6d6c240-gcCjisV9jQvt6CYOjUkM1NxU.gif)

In your root directory, make a new file called nft-metadata.json and add the following json code:

<!--  -->

```json nft-metadata.json
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

<!--  -->

Feel free to change the data in the json. You can add or remove attributes. Most importantly, make sure the image field points to the location of your IPFS image— otherwise, your NFT will not include a photo of a (very cute!) dog.

Once you're done editing the json file, save it and upload it to Pinata, following the same steps we did for uploading the image.

![](https://files.buildwithfern.com/https://alchemy.docs.buildwithfern.com/docs/2025-07-16T20:14:47.594Z/tutorials/creating-smart-contracts/how-to-create-an-nft-on-ethereum-tutorial/4fb1d9b-77NWEdyRHvtY4Da2CGi2S4SW.gif)

### Step 4: Create a Signer and an Instance of the Contract

In order to be able to call the functions on our deployed contract, we need to define an ethers `Signer` using our wallet's private key. Next, we need to use the contract's deployed address, the contract ABI, and the aforementioned signer to define a `contract` instance.

In the `mint-nft.js` file, add the following code:

```javascript mint-nft.js
// Create a signer
const privateKey = process.env.PRIVATE_KEY;
const signer = new ethers.Wallet(privateKey, provider);

// Get contract ABI and address
const abi = contract.abi;
const contractAddress = "0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220";

// Create a contract instance
const myNftContract = new ethers.Contract(contractAddress, abi, signer);
```

In the snippet above, you can see that our contract's deployed address is `0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220`. If you don't remember your contract address or can't find it on Etherscan, simply re-deploy the contract from Part 1 again and note down the new address.

### Step 5: Call mintNFT function of the contract

Remember the metadata.json you uploaded to Pinata? Get its hashcode from Pinata and pass the following into a call to `mintNFT` [https://gateway.pinata.cloud/ipfs/\<metadata-hash-code>](https://gateway.pinata.cloud/ipfs/%3Chash-code%3E)

Here's how to get the hashcode:

![](https://files.buildwithfern.com/https://alchemy.docs.buildwithfern.com/docs/2025-07-16T20:14:47.594Z/tutorials/creating-smart-contracts/how-to-create-an-nft-on-ethereum-tutorial/e7cecbb-AnI4KrRVhT6RWzcXcivtp9ig.gif)

<Warning>
  Double check that the hashcode you copied links to your **metadata.json** by loading [https://gateway.pinata.cloud/ipfs/\<metadata-hash-code>](https://gateway.pinata.cloud/ipfs/%3Chash-code%3E) into a separate window. The page should look similar to the screenshot below:
</Warning>

![](https://prod.ferndocs.com/_next/image?url=https%3A%2F%2Ffiles.buildwithfern.com%2Fhttps%3A%2F%2Falchemy.docs.buildwithfern.com%2Fdocs%2F2025-07-16T20%3A14%3A47.594Z%2Ftutorials%2Fcreating-smart-contracts%2Fhow-to-create-an-nft-on-ethereum-tutorial%2F491013b-image_19.png&w=3840&q=75)

Now add the following piece of code to `mint-nft.js` to call the `mintNFT` function:

```javascript mint-nft.js
// Get the NFT Metadata IPFS URL
const tokenUri =
  "https://gateway.pinata.cloud/ipfs/bafkreibytsze3xenwgums3xqwnx5d4qoydezt4pcxzzpodomxcsdhhlavu";

// Call mintNFT function
const mintNFT = async () => {
  let nftTxn = await myNftContract.mintNFT(signer.address, tokenUri);
  await nftTxn.wait();
  console.log(
    `NFT Minted! Check it out at: https://sepolia.etherscan.io/tx/${nftTxn.hash}`
  );
};

mintNFT()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

The final `mint-nft.js` file should look something like this:

```javascript mint-nft.js
require("dotenv").config();
const ethers = require("ethers");

// Get Alchemy App URL
const API_KEY = process.env.API_KEY;

// Define an Alchemy Provider
const provider = new ethers.providers.AlchemyProvider("sepolia", API_KEY);

// Get contract ABI file
const contract = require("../artifacts/contracts/MyNFT.sol/MyNFT.json");

// Create a signer
const privateKey = process.env.PRIVATE_KEY;
const signer = new ethers.Wallet(privateKey, provider);

// Get contract ABI and address
const abi = contract.abi;
const contractAddress = "0x354EcEb2bd747ec0d4acC370b77Fe28415F4f220";

// Create a contract instance
const myNftContract = new ethers.Contract(contractAddress, abi, signer);

// Get the NFT Metadata IPFS URL
const tokenUri =
  "https://gateway.pinata.cloud/ipfs/bafkreibytsze3xenwgums3xqwnx5d4qoydezt4pcxzzpodomxcsdhhlavu";

// Call mintNFT function
const mintNFT = async () => {
  let nftTxn = await myNftContract.mintNFT(signer.address, tokenUri);
  await nftTxn.wait();
  console.log(
    `NFT Minted! Check it out at: https://sepolia.etherscan.io/tx/${nftTxn.hash}`
  );
};

mintNFT()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

We're all set. Let's mint our NFT by running the following command:

```shell shell
node scripts/mint-nft.js
```

You should get an output that looks something like this:

```shell shell
NFT Minted! Check it out at: https://sepolia.etherscan.io/tx/0x721adae139222cfa5743836e66ce422e61c1b07fd3d16d1fc822f2dd0b5153cc
```

You can check out your NFT mint on Etherscan by following the URL above.

You can view your NFT on OpenSea by searching for your contract address. Check out [our NFT here](https://testnets.opensea.io/collection/mynft-15112).

Using the `mint-nft.js` you can mint as many NFT's as your heart (and wallet) desires! Just be sure to pass in a new `tokenURI` describing the NFT's metadata --otherwise, you'll just end up making a bunch of identical ones with different IDs.

Presumably, you'd like to be able to show off your NFT in your wallet 😉— so be sure to check out Part III: [How to View Your NFT in Your Wallet](https://docs.alchemyapi.io/alchemy/tutorials/how-to-write-and-deploy-a-nft-smart-contract/how-to-view-your-nft-in-your-wallet).
