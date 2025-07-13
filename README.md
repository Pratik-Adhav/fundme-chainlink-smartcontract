# 🪙 FundMe Smart Contract — With Chainlink Price Feed Integration

This is a Solidity-based crowdfunding-style smart contract that accepts ETH **only if it meets a minimum USD threshold**, powered by **Chainlink ETH/USD price feeds**.

Built as a learning project to understand:
- Oracle integration (Chainlink)
- Access control with `onlyOwner`
- Safe ETH withdrawal patterns
- Gas optimizations with `constant`, `immutable`, and `custom errors`

---

## 📌 Features

| Feature                       | Description                                       |
|-------------------------------|---------------------------------------------------|
| USD Threshold                 | Only accepts ETH worth **at least $50 USD**       |      
| Chainlink Oracle              | Fetches real-time ETH/USD conversion              |
| Funder Tracking               | Records who sent ETH and how much                 |
| Owner-Only Withdrawals        | Only contract creator can withdraw                |
| Gas Optimized                 | Uses `constant`, `immutable`, `custom error`      |
| Auto ETH Handling             | `receive()` and `fallback()` support direct ETH   |

---

## 💡 Real-World Analogy

Think of this contract like a **donation box**:

- People (like "Etha" 🧍) can donate ETH
- But it only accepts donations **worth $50 or more** in real-time USD value
- You (the contract creator) are the only one allowed to withdraw the funds
- The contract safely tracks all donors and protects against misuse

---

## 🧠 Key Concepts Used

- `msg.sender`, `msg.value`, `address(this).balance`
- Chainlink AggregatorV3Interface
- Price conversion using custom library (`PriceConverter`)
- `onlyOwner` modifier using `immutable i_owner`
- Gas-optimized `NotOwner()` custom error
- `transfer`, `send`, and `call` ETH withdrawal methods
- `receive()` and `fallback()` to catch direct ETH transactions

---

## 📂 File Structure

```bash
contracts/
├── FundMe.sol             # Main contract
├── PriceConverter.sol     # Chainlink price feed logic
README.md

🔗 Chainlink Price Feed
Using Chainlink ETH/USD feed for Sepolia testnet:
**Please use the contract address for price feed for your particular testnet by refering this website: https://docs.chain.link/data-feeds/price-feeds/addresses/**
AggregatorV3Interface @ 0x694AA1769357215DE4FAC081bf1f309aDC325306

🔧 How to Deploy (via Remix)
- Open Remix IDE
- Paste both FundMe.sol and PriceConverter.sol
- Compile with Solidity v0.8.18
- Inject Web3 provider (MetaMask + Sepolia network)
- Deploy the contract
- Interact via fund(), withdraw(), or send ETH directly to the contract

🧪 Testing
- Try sending < $50 worth of ETH → Rejected
- Send > $50 worth of ETH → Accepted
- Only owner can call withdraw()
- call, send, and transfer logic tested inside contract
