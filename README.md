# Oolong.xyz

Oolong is an automation services for Gnosis pay. Hold as much sDai as you want, set a target amount of EURe to hold for VISA transactions and let Oolong do the rest. Anytime your EURe balance is below your target, Oolong network will automatically convert sDai to EURe to top up your account. Oolong is a decentralized network of nodes that are incentivized to keep your EURe balance topped up to your target amount.Anyone can become an Oolong node and earn fees for keeping EURe balances topped up.


## Why Oolong?

Solves a Real Problem: In a world where digital asset management can be time-consuming and complex, Oolong simplifies the process, enabling users to focus on what matters most to them.
Decentralized and Secure: Leveraging a decentralized network of nodes, Oolong ensures that your currency conversion and balance management are secure, reliable, and always on.
Innovative Incentive Model: Nodes within the Oolong network are incentivized to maintain optimal operation, ensuring your balances are topped up efficiently, with a transparent and fair fee structure.

## How It Works

* Deployment: Users deploy an Oolong contract and specify their target EURe balance. This sets the stage for automated balance management.
* Monitoring and Conversion: Oolong nodes continuously monitor your SAFE account. Whenever your EURe balance dips below the target, the network converts sDai to EURe to replenish your funds.
* Permission and Security: Users grant the Oolong contract permission to execute transactions on their behalf, with robust security measures in place to protect their assets.
* Fees and Incentives: A nominal fee for this service is split between the performing node and the Oolong network, fostering a sustainable and thriving ecosystem.


## How to use

### Testing

To Run tests, you need to have a local fork of the Gnosis chain. You can use the following command to run tests with a local fork.

Make sure you also full in the .env file with the correct values.

```bash
forge test -vvvv --fork-url https://rpc.gnosischain.com/

```

### Running in Live

This will run the script on mainnet. Make sure you have the correct values in the .env file!

```bash
source .env && forge script script/topUp.s.sol:TopUp -vvvv --fork-url https://rpc.gnosischain.com/ --broadcast 

```


## Deployments on mainnet

balance controller contract: https://gnosisscan.io/address/0x60FDA2923de9e9ce238Aa9AF27Ef6C7F57c70A2b#code


