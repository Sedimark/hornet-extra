# wasp-extra

A Wasp network is deployed on LINKS servers on top of the L1 Tangle as an L2 layer of IOTA. The following instructions explain how to deploy and connect other Wasp nodes to the network.

## Requirements

- Software: `docker`, `docker compose`, at least a Hornet node in the LINKS network. Follow [`hornet-extra`](https://github.com/Sedimark/hornet-extra) instructions. 

```sh
mkdir wasp-node 
cd wasp-node
wget https://github.com/iotaledger/wasp/releases/download/v1.0.3/wasp-cli_1.0.3_Linux_x86_64.tar.gz
tar -xzf wasp-cli_1.0.3_Linux_x86_64.tar.gz
git clone https://github.com/iotaledger/wasp.git
cd wasp/tools/localsetup
 # update docker-compose
 docker compose up -d
```

https://github.com/iotaledger/wasp

##
Configure the wasp-cli: https://wiki.iota.org/wasp/how-tos/wasp-cli/
wasp-cli

```sh
./wasp-cli init
./wasp-cli set l1.apiaddress http://localhost:14268 # chage this if you change the configuration
# the faucet only exists for test networks
./wasp-cli set l1.faucetaddress faucet.tangle.stardust.linksfoundation.com
./wasp-cli wasp add <node-name> http://127.0.0.1:9090
```

mention -> --skip-version-check


## Add the Wasp



To add the Wasp node first it is necessary to know its `PublicKey` and its `PeeringURL`.
Communicate those values to the owners of the Wasp nodes in the network.
They should add your node to their trusted nodes, and you should add their nodes to your trusted nodes, to do so run the command:
```sh
wasp-cli peering trust <node-name> <PubKey> <PeeringURL>
```

All the nodes in a committee must trust each other to run a chain.
You can view the list of your wasp node's trusted peers by calling:
```sh
wasp-cli peering list-trusted
```

# Add a Chain
to activate a chain on a Wasp node run this commands:
```sh
wasp-cli chain add <name> <chainID> # adds the chain to the wasp-cli config
wasp-cli chain activate --chain=<name>
```
The first command adds to the Wasp-cli the chain, can be skipped on the wasp-cli that initiated the deployment.
The second command activate the chain on the Wasp node. 
NOTE that with the last command the Wasp node does not become a member of the Set of Validators.

## Become a Member of the Committee of a chain
To be inserted in the Set of Validators one of the members first need to add to its wasp-cli your node, he needs your `WebAPI` address to run this command 

```sh
wasp-cli wasp add <wasp-name> <WebAPI> 
```
then to add your node he can run:
```sh
wasp-cli chain rotate-with-dkg --chain=<chain-name> --peers=<...>
```
where the peer are the wasp-name the owner gave to the Wasp nodes he want to make members of the Set of Validators


## Something

TO access jrpc you can use json-rpc.evm.stardust.linksfoundation.com or ...


To access the dashboard go to http://localhost:90/wasp/dashboard