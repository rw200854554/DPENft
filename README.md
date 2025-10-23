# 🐧 DPenguin NFT Collection

A Foundry-based NFT project featuring cute penguin NFTs with dynamic SVG artwork and interactive features. This repository contains both a basic NFT implementation and an advanced DPE (DPenguin) NFT with flipable views and on-chain metadata.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Smart Contracts](#smart-contracts)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Deployment](#deployment)
- [Scripts](#scripts)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### BasicNFT Contract
- Simple ERC721 implementation
- Custom token URI mapping
- Basic minting functionality

### DPENft Contract (Advanced)
- **Dynamic SVG Artwork**: On-chain SVG images with Base64 encoding
- **Flipable Views**: Switch between front and side views of penguins
- **On-chain Metadata**: Complete token metadata stored on-chain
- **Payable Minting**: Minimum cost of 0.05 ETH for public minting
- **Owner Controls**: Add new penguin designs and withdraw funds
- **Fallback/Receive**: Automatic minting when ETH is sent to contract
- **Rich Attributes**: Detailed trait metadata for each NFT

## 🏗️ Project Structure

```
foundry-nft/
├── src/                    # Smart contracts
│   ├── BasicNFT.sol       # Basic ERC721 implementation
│   └── DPENft.sol         # Advanced penguin NFT with features
├── script/                 # Deployment and interaction scripts
│   ├── DeployBasicNFT.s.sol
│   ├── DeployDPENft.s.sol
│   └── Interactions.s.sol
├── test/                   # Test files
│   ├── units/             # Unit tests
│   └── Integration/       # Integration tests
├── img/                    # SVG artwork files
├── broadcast/              # Deployment artifacts
├── out/                    # Compiled contracts
└── lib/                    # Dependencies
    ├── forge-std/
    ├── foundry-devops/
    └── openzeppelin-contracts/
```

## 🔧 Smart Contracts

### BasicNFT.sol
A simple ERC721 implementation for basic NFT functionality:
- Constructor sets name "Dpenguin" and symbol "DPE"
- `mintNFT(string memory tokenUri)`: Mints NFT with custom URI
- `tokenURI(uint256 tokenId)`: Returns the URI for a given token

### DPENft.sol
Advanced NFT contract with rich features:

**Key Functions:**
- `mintNft()`: Payable minting (0.05 ETH minimum for non-owners)
- `flipView(uint256 tokenId)`: Switch between front/side views
- `addDPE(...)`: Owner-only function to add new penguin designs
- `withdraw()`: Owner-only function to withdraw contract funds
- `tokenURI(uint256 tokenId)`: Returns dynamic metadata with current view

**Features:**
- Dynamic SVG artwork stored on-chain
- Two view modes: FRONT and RIGHT (side view)
- Rich metadata with traits and attributes
- Owner controls for adding new designs
- Automatic minting via fallback/receive functions

## 🚀 Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/downloads)
- Node.js (for development tools)

## 📦 Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd foundry-nft
```

2. Install dependencies:
```bash
forge install
```

3. Build the project:
```bash
forge build
```

## 🎯 Usage

### Compile Contracts
```bash
forge build
```

### Run Tests
```bash
# Run all tests
forge test

# Run with verbosity
forge test -vvv

# Run specific test file
forge test --match-path test/units/DPENftTest.t.sol
```

### Deploy Contracts

#### Deploy to Anvil (Local)
```bash
# Start Anvil in one terminal
anvil

# Deploy DPE NFT in another terminal
make deploy-anvil-dpe
```

#### Deploy to Sepolia Testnet
```bash
# Set up environment variables
export SEPOLIA_RPC_URL="your-sepolia-rpc-url"
export ETHSCAN_KEY="your-etherscan-api-key"
export PRIVATE_KEY="your-private-key"

# Deploy
make deploy-sepolia-dpe
```

#### Deploy to Other Networks
```bash
# Arbitrum
make deploy-arb-dpe

# zkSync Era
make deploy-zk-dpe
```

### Interact with Contracts

#### Mint NFTs
```bash
# Mint DPE NFT
make mint-dpe

# Mint on specific network
make mint-arb-dpe
make mint-zk-dpe
```

#### Local Testing
```bash
# Mint on Anvil
make mint-anvil
```

## 🧪 Testing

The project includes comprehensive test coverage:

### Unit Tests
- `DPENftTest.t.sol`: Tests core DPE NFT functionality
- `DeployDPENftTest.t.sol`: Tests deployment script

### Integration Tests
- `DPENftIntegrationTest.t.sol`: End-to-end integration tests
- `BasicNftTest.t.sol`: Basic NFT functionality tests

### Running Tests
```bash
# Run all tests
forge test

# Run with gas reporting
forge test --gas-report

# Run specific test
forge test --match-test testMintNft
```

## 🚀 Deployment

### Environment Setup
Create a `.env` file with your configuration:
```bash
SEPOLIA_RPC_URL="your-sepolia-rpc-url"
ARB_RPC_URL="your-arbitrum-rpc-url"
ZK_RPC_URL="your-zksync-rpc-url"
ETHSCAN_KEY="your-etherscan-api-key"
ANVIL_PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
```

### Available Deployment Commands
```bash
# Basic NFT
make deploy-sepolia-basic

# DPE NFT
make deploy-sepolia-dpe
make deploy-arb-dpe
make deploy-zk-dpe

# SVG Storage
make deploy-sepolia-svg
```

## 📜 Scripts

### DeployDPENft.s.sol
Deploys the DPE NFT contract with initial penguin design:
- Reads SVG files from `img/` directory
- Converts SVG to Base64 encoded data URIs
- Sets up initial metadata and attributes

### Interactions.s.sol
Contains interaction scripts:
- `MintBasicNFT`: Mints basic NFTs
- `MintDPENFT`: Mints DPE NFTs
- `SendSVG`: Sends SVG data to contract (commented out)

## 🎨 Artwork

The project includes SVG artwork files in the `img/` directory:
- `DPEFrontFinalc.svg`: Front view of penguin
- `miniDPEsidec.svg`: Side view of penguin
- Additional artwork files for different designs

## 🔧 Development

### Adding New Penguin Designs
1. Add SVG files to `img/` directory
2. Use `addDPE()` function to add new designs:
```solidity
dpeNft.addDPE(
    frontSvgUri,
    sideSvgUri,
    description,
    name
);
```

### Customizing Metadata
Modify the description format in `DeployDPENft.s.sol`:
```solidity
string memory dpeDescription = '"attributes":[{"trait_type":"Headwear","value":"Straw hat"},...]';
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [OpenZeppelin](https://openzeppelin.com/) for ERC721 implementation
- [Foundry](https://book.getfoundry.sh/) for development framework
- [Foundry DevOps](https://github.com/Cyfrin/foundry-devops) for deployment tools

---

**Note**: This is a development project. Always test thoroughly on testnets before deploying to mainnet. The minimum minting cost and other parameters can be adjusted based on your requirements.