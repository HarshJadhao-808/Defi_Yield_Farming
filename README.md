# Mini DeFi Ecosystem – Yield Farming & DEX

A simplified **DeFi ecosystem** built using **Solidity and Foundry** that demonstrates important decentralized finance concepts such as **staking, yield farming, automated market makers (AMM), liquidity pools, and LP tokens**.

This project contains **four smart contracts** working together to simulate a basic DeFi protocol.

---

# Project Overview

The system consists of:

* **HCoin (HC)** – Primary token used in the ecosystem
* **YieldCoin (YT)** – Reward token generated through staking
* **Stake Contract** – Allows users to stake HC and earn rewards
* **DEX Contract** – Enables swapping HC ↔ YT and liquidity provision

Users can:

* Receive **HC tokens**
* **Stake HC** to earn YieldCoin
* **Swap HC and YT** using the decentralized exchange
* **Provide liquidity** to earn LP tokens
* **Remove liquidity** and receive their share of tokens

---

# Smart Contracts

## 1. HCoin (HC)

HCoin is the **main token** of the ecosystem.

### Features

* ERC20 Token
* Distributed to users when they interact with the system
* Can be used for:

  * Staking
  * Trading on the DEX
  * Providing liquidity

---

## 2. YieldCoin (YT)

YieldCoin is the **reward token** for staking.

### Features

* ERC20 Token
* Minted as **staking rewards**
* Can be traded against **HC** in the DEX

---

## 3. Staking Contract

The staking contract allows users to **lock HC tokens and earn YieldCoin rewards**.

### Flow

1. User deposits **HC tokens**
2. Contract records the **staked balance**
3. Over time, user earns **YieldCoin rewards**
4. User can **withdraw HC and rewards**

### Purpose

Demonstrates the concept of:

* Yield Farming
* Passive income in DeFi
* Token reward distribution

---

## 4. DEX (Automated Market Maker)

The DEX contract allows users to **swap HC and YT tokens without a centralized exchange**.

It uses a **liquidity pool model** similar to **Uniswap**.

### Core Features

* HC ↔ YT swaps
* Liquidity pools
* LP token minting
* Liquidity removal
* Trading fees

---

# Automated Market Maker Model

The exchange follows the **constant product formula**:

```
x * y = k
```

Where:

```
x = HC reserve
y = YT reserve
k = constant product
```

This ensures that prices adjust automatically based on supply and demand.

---

# Liquidity Pools

Liquidity providers deposit **HC and YT tokens** into the pool.

Example:

```
Pool:
100 HC
1000 YT
```

A user can add liquidity:

```
10 HC
100 YT
```

The ratio must match the pool ratio.

---

# LP Tokens

When users provide liquidity, the contract mints **LP tokens**.

LP tokens represent the **user's ownership share of the pool**.

Example:

```
User owns 10% of LP tokens
→ User owns 10% of pool liquidity
```

LP tokens allow users to:

* Track their share
* Earn trading fees
* Remove liquidity later

---

# Liquidity Minting Formula

Initial liquidity:

```
LP = √(HC × YT)
```

Additional liquidity:

```
LP minted = (HC added × total LP supply) / HC reserve
```

---

# Removing Liquidity

To withdraw liquidity:

1. User sends LP tokens
2. LP tokens are **burned**
3. Contract calculates user's share

Formula:

```
HC returned = LP × reserveHC / totalLP
YT returned = LP × reserveYT / totalLP
```

User receives tokens proportional to their share of the pool.

---

# Swap Fee

A small **trading fee** is charged on swaps.

Example:

```
0.5% fee
```

Formula used:

```
amountInWithFee = amountIn − (fee × amountIn)
```

The fee remains inside the pool, which increases liquidity provider rewards.

---

# Project Structure

```
Repository
│
├── README.md
│
└── YIELD_FARMING
     │
     ├── src
     │   ├── HCoin.sol
     │   ├── YieldCoin.sol
     │   ├── Stake.sol
     │   └── DEX.sol
     │
     ├── script
     ├── test
     └── foundry.toml
```

---

# Running the Project (Foundry)

Install dependencies:

```
forge install
```

Build contracts:

```
forge build
```

Run tests:

```
forge test
```

---

# Learning Goals

This project demonstrates key **DeFi and blockchain concepts**:

* ERC20 token implementation
* Staking mechanisms
* Yield farming
* Automated Market Makers (AMM)
* Liquidity pools
* LP tokens
* Token swaps
* Smart contract architecture

---

# Future Improvements

Possible enhancements:

* Price oracle integration
* Time-based staking rewards
* Dynamic trading fees
* Frontend UI
* Slippage protection
* Flash loan protection

---

# Conclusion

This project is a simplified **DeFi protocol simulation** that demonstrates how modern decentralized exchanges and yield farming platforms work.

It provides a strong foundation for understanding protocols like:

* Uniswap
* SushiSwap
* PancakeSwap
* Curve
