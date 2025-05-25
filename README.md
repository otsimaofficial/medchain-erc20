# MedChain ERC20 Token

This project contains a basic implementation of an ERC20 token named **Med Token (MED)**, developed as part of a blockchain developer cohort assignment.

## 📜 Description

The `MedChain` contract is a simplified custom ERC20 token written in Solidity. It allows minting an initial token supply and supports standard `transfer`, `approve`, and `transferFrom` functionalities.

The contract and test cases were written and compiled using [Foundry](https://book.getfoundry.sh/) – a blazing-fast, portable, and modular toolkit for Ethereum application development.

## 🧱 Project Structure

erc20/
├── foundry.toml # Foundry config file
├── src/ # Solidity contracts
│ └── medChain.sol # Main MedChain ERC20 token contract
├── test/ # Test files
│ └── medChain.t.sol # Unit tests for MedChain
├── script/ # (Optional) Deployment or interaction scripts
├── lib/ # External libraries like forge-std
└── .gitignore # Ignored files/folders


## 🛠️ Tools & Frameworks

- Solidity ^0.8.0
- Foundry (Forge)
- forge-std (for testing utilities)

## 🧪 How to Test

To run the tests locally:

```bash
forge test

📝 Author
Emmanuel Otsima Ogbu
Blockchain Developer Cohort – 2025