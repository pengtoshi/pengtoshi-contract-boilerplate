# Contract Boilerplate

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?color=green&labelColor=#5D5D5D)](https://github.com/toss/suspensive/blob/main/LICENSE)

> Smart contract development boilerplate for EVM-compatible chains.
> <br>

<br/>

## 📦 Building Contracts

Run the following command to build the contracts.<br/>
It uses hardhat and foundry both - `hardhat compile` and `forge build` will be executed. Also it generates the **typechain bindings** for the contracts.

```
yarn build
```

<br/>

## 🚀 Deploying Contracts

This boilerplate uses `hardhat-deploy` for deploying the contracts.
But it also uses `openzeppelin-upgrades` for deploying the UUPS upgradeable contracts(Since `hardhat-deploy` does not support UUPS upgradeable patterns). If you use the non-UUPS upgradeable patterns, you can either use `hardhat-deploy` for deploying the upgradeable contracts.

### Deploying to a new network

1. Add the network to the `hardhat.config.ts` file.
2. Add the new .env file to the `tools/env` folder. The name should be like `.env.${network}`.
3. Create a new folder in the `scripts/deploy` folder. You can copy the `base_sepolia` folder for the reference. As a result, the folder structure should be like below:

```
📁 scripts/deploy
├── 📁 ${network}
│   ├── 📁 done            # The scripts that have been done.
│   └── 📁 todo            # The scripts that are not done.
```

4. Run the scripts below to deploy the contracts. Either you can add the shortcuts to the `package.json`.

```
"dotenv -e ./tools/env/.env.${network} -- npx hardhat deploy --network ${network} --export ./deployments/${network}.json"
```

<br/>

## 🧪 Testing

This boilerplate uses `Foundry` for testing.<br/>
For more information about testing with Foundry, see the [Foundry Book](https://book.getfoundry.sh/forge/tests).

### Fixtures

Fixtures are used to initialize the test environment.

- `BaseFixture` (in `test/common`): **A base fixture for all test suites**. It initializes the users and deploys the contract instances.
- `BaseForkFixture` (in `test/fork`): **A base fixture for all fork test suites**. It works similar to `BaseFixture` but it gets the deployed contract instances from a _forked network_. You should add the contract addresses to the `addresses.json` file.
