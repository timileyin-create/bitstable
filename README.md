# Stablecoin Vault Contract

A decentralized stablecoin system built on Stacks that enables users to create collateralized debt positions (CDPs) using STX as collateral.

## Overview

The Stablecoin Vault Contract implements a decentralized stablecoin system where users can:

- Create vaults by depositing STX as collateral
- Mint stablecoins against their collateral
- Manage their positions (repay debt, withdraw collateral)
- Get liquidated if their position falls below the liquidation ratio

## Key Features

- **Collateralized Debt Positions (CDPs)**

  - Minimum collateralization ratio: 150%
  - Liquidation threshold: 120%
  - Dynamic stability fee mechanism

- **Price Oracle Integration**

  - Real-time collateral valuation
  - Multiple oracle support
  - Price validity checks

- **Risk Management**
  - Liquidation mechanism
  - Emergency shutdown capability
  - Governance controls for risk parameters

## Quick Start

1. Initialize the contract with a valid price:

```clarity
(contract-call? .stablecoin-vault initialize u50000000)
```

2. Create a vault and deposit collateral:

```clarity
(contract-call? .stablecoin-vault create-vault u1000000)
```

3. Mint stablecoins against your collateral:

```clarity
(contract-call? .stablecoin-vault mint-stablecoin u500)
```

## Documentation

- [Technical Specification](docs/technical-specification.md)
- [Security Policy](SECURITY.md)
- [Contributing Guidelines](CONTRIBUTING.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)

## Contract Parameters

- Minimum Collateral Ratio: 150%
- Liquidation Ratio: 120%
- Stability Fee: 2% annual
- Maximum Price: 1,000,000,000
- Minimum Price: 1
- Maximum Ratio: 1000%
- Minimum Ratio: 101%
- Maximum Fee: 100%
