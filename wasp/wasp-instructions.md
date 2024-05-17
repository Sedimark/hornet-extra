# wasp-extra

A Wasp network is deployed on LINKS servers on top of the L1 Tangle as an L2 layer of IOTA. The following instructions explain how to deploy and connect other Wasp nodes to the network.

## Requirements

- Software: `docker`, `docker compose`, at least a Hornet node in the LINKS network. Follow [`hornet-extra`](https://github.com/Sedimark/hornet-extra) instructions. 

```sh
mkdir ./privatedb/wasp-db
wget https://github.com/iotaledger/wasp/releases/download/v1.0.3/wasp-cli_1.0.3_Linux_x86_64.tar.gz
tar -xzf wasp-cli_1.0.3_Linux_x86_64.tar.gz
# to start the node run:
docker compose up -d
```

## Wasp-cli
Configure the wasp-cli: https://wiki.iota.org/wasp/how-tos/wasp-cli/
wasp-cli

```sh
./wasp-cli init
./wasp-cli set l1.apiaddress https://api.tangle.stardust.linksfoundation.com 
./wasp-cli set l1.faucetaddress https://faucet.tangle.stardust.linksfoundation.com
./wasp-cli wasp add <node-name> http://<your-public-ip>:9090
```
`<node-name>` is a name of your choice for your Wasp node
If the version of the wasp-cli is not the same of the wasp node an error 
appear but add the `--skip-version-check` at the end of every command to suppress it.
In such case you can also download the corrisponding version.


## Add the Wasp
### You have to:
add to the trusted peers of your wasp the nodes that are in the committee of the chain you want to join as a committee member.
To do so you need to know the `PublicKeys` and their `peeringURL` of the wasp nodes in the committee.
The three wasp nodes in the links network have these values:

| Wasp   |                                   PublicKey                            |                       PeeringURL                        |
|--------|------------------------------------------------------------------------|---------------------------------------------------------|
| wasp-links | 0xd1467f40d1d93e77c70247446d50ced8a69aa0cb76551d04d63072bb07e8fc86 |  stardust.linksfoundation.com:4000                      |

To add them run the command:
```sh
wasp-cli peering trust <node-name> <PubKey> <PeeringURL>
```
`<node-name>` is the name that you want to give inside *your* wasp-cli to the node with 
that `PublicKeys` and `peeringURL`

To be sure that the `trust` command went well you can run:
```sh
wasp-cli peering list-trusted
```
that will list all the Wasp nodes you trust, at the beginning there will be just a line 
respresenting your node, this line starts with `me`

Then you need to communicate *your* Wasp `PublicKeys` and `peeringURL` to all the members 
of the Committee because all the nodes in a committee must trust each other to run a chain.

To know your public key run:
```sh
wasp-cli peering info
```
you'll receive something like
```
PubKey: 0xd1467f40d1d93e77c70247446d50ced8a69aa0cb76551d04d63072bb07e8fc86
PeeringURL: 0.0.0.0:4000
```
the `PeeringURL` is usefull to know the port, but `0.0.0.0` must be replaced with your Wasp
public ip or otherwise the whole string could be replaced with an URL you defined.

# Add a Chain

| Chain Name      |                          Chain ID                               |
|-----------------|-----------------------------------------------------------------|
| sedimark-chain  | tst1pqp99nwxp8zwsuqzmj4dttn558c54y0hl3d4nw3aq6szk44x7w4cchvh826 |


To activate a chain on a Wasp node run this commands:
```sh
wasp-cli chain add <name> <chainID> # adds the chain to the wasp-cli config
wasp-cli chain activate --chain=<name>
```

The first command adds to the Wasp-cli the chain.
The second command activate the chain on the Wasp node. 
NOTE that with the last command the Wasp node does not become a member of the Set of Validators.

## Add a Member to the Committee of a chain
**This part has to be run only by a meber of the committee**

To be inserted in the Committee one of them first all the members should trust your node with the command:

```sh
wasp-cli peering trust <node-name> <PubKey> <PeeringURL>
```
then to add your node in the committee the memember can run:
```sh
wasp-cli chain rotate-with-dkg --chain=<chain-name> --peers=<...>
```
where the peers are the wasp-name the owner gave to the Wasp nodes he want to make members of the Set of Validators, between those he trust.


## Wasp Dashboard

To access the dashboard go to http://127.0.0.1:90/wasp/dashboard