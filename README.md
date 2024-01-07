# DeFi Lending

DeFi Lending is a decentralized finance (DeFi) application built on the Ethereum blockchain. This project allows users to deposit, withdraw, borrow, and repay Ether (ETH) directly within the smart contract.

## Features

- **Deposit**: Users can deposit ETH into the contract. The deposited ETH is added to the user's balance and the total ETH in the contract.

- **Withdraw**: Users can withdraw their deposited ETH. The withdrawn ETH is deducted from the user's balance and the total ETH in the contract.

- **Borrow**: Users can borrow ETH from the contract. The borrowed ETH is added to the user's borrowed amount and deducted from the total ETH in the contract.

- **Repay**: Users can repay their borrowed ETH. The repaid ETH is deducted from the user's borrowed amount and added back to the total ETH in the contract.

## Getting Started

To get started with this project, clone the repository and install the dependencies.

```bash
git clone https://github.com/yourusername/defi-lending.git
cd defi-lending
npm install
```

## Running the Tests

To run the tests, use the following command:

```bash
forge test
```

## Deployment

To deploy the contract to the Ethereum network, use the following command:

```bash
forge deploy --network mainnet
```

Replace `mainnet` with the desired network (e.g., `ropsten`, `rinkeby`).

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
