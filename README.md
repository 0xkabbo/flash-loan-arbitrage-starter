# Flash Loan Arbitrage Starter

A high-quality Solidity implementation for interacting with Aave V3 Flash Loans. This repository is designed for developers building automated trading strategies that require instant, uncollateralized liquidity.

## Features
* **Aave V3 Integration:** Implements the `IFlashLoanSimpleReceiver` interface for the latest Aave protocol.
* **Safety Guardrails:** Includes logic to ensure the loan is only executed if the resulting trade is profitable.
* **Gas Optimized:** Minimal overhead to ensure maximum efficiency during competitive arbitrage opportunities.
* **Flat Structure:** All logic contained in the root for rapid deployment and testing.

## Workflow
1. **Request:** The contract requests a specific amount of an asset from the Aave Pool.
2. **Execute:** The `executeOperation` function is triggered by the Pool.
3. **Arbitrage:** Your custom logic swaps the borrowed funds across DEXs.
4. **Repay:** The contract automatically calculates and returns the principal plus the flash loan fee.
