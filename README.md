## Oolong.xyz

Oolong is an automation services for Gnosis pay. Hold as much sDai as you want, set a target amount of EURe to hold for VISA transactions and let Oolong do the rest.

Anytime your EURe balance is below your target, Oolong network will automatically convert sDai to EURe to top up your account. 

Oolong is a decentralized network of nodes that are incentivized to keep your EURe balance topped up to your target amount. 

Anyone can become an Oolong node and earn fees for keeping EURe balances topped up.

## How it works

First deploy an Oolong contract and set your target EURe balance. Oolong nodes will monitor your SAFE account and top up your EURe balance to your target amount whenever you send. Oolong network takes a small fee for this service. Split 50/50 between the node and the Oolong network. 

Then set the Oolong contract as an owner of your safe to allow it to send transactions on your behalf.

## Dev Introductions

### Testing

To Run tests, you need to have a local fork of the Gnosis chain. You can use the following command to run tests with a local fork.

Make sure you also full in the .env file with the correct values.

```bash
forge test -vvvv --fork-url https://rpc.gnosischain.com/

```

### Running in Live



