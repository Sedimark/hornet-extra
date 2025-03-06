# SEDIMARK DLT Node Docker-compose Setup

This setup is the one used in LINKS Foundation to deploy the network main node, this runs the Coordinator and the needed services for it.
This also spins up a an IOTA Hornet node (L1) and an IOTA Wasp node (L2) along with other services to give you more monitoring options (Grafana and Prometheus).

This set up deploys also the Faucets, both for L1 and L2 network.

It uses Docker for containerisation and Traefik as a reverse proxy, so you can manage access to your nodes and ensure that your requests are sent to the correct endpoints. 

## Warning DO NOT deploy the Coordinator
In the network just one coordinator is needed, so if it is desired to use this configuration in your .env file comment this line:
```
COMPOSE_PROFILES=${COMPOSE_PROFILES},coordinator
``` 
in order to not run the coordinator profile.

## Remember to:
### Generate your Hornet private key: 
use the command:
```bash
docker compose run hornet-extra tool p2pidentity-gen
```
and save the generated private key in your .env file
### Generate Hornet Dashboard Password
The Hornet Dashboard needs in the .env file the hased password and the salt. 
use the command:
```bash
docker compose run hornet-extra tool pwd-hash 
```
### Generate Wasp Dashboard User
To generate a user for the wasp dashboard there are two ways. 

1. Run the wasp node for the first time, login to the wasp dashboard with the user:admin pw:admin then click the plus add your user and password and enable the write permission. Then remove the admin user.

2. with the command: 
```bash
docker compose run hornet-extra tool pwd-hash 
```
generate password and salt. Then in the folder ```./data/wasp/``` edit the file ```users.json``` in this way:
```json

{
  "users": {
    "users": {
      "<username>": {
        "PasswordHash": "xxxxxxxxxxxx",
        "PasswordSalt": "xxxxxxxxxxxx",
        "Permissions": [
          "write",
          "read"
        ]
      }
    }
  }
}
```
save the file and run:
```bash
docker compose up -d --remove-orphans
```

## Run the Node
After generating the private key run
```bash
sudo ./bootstrap.sh # to be done only the first time
```
Just run it once. If the node is switched off there is no need to run it again.

Then run
```bash
docker compose up -d --remove-orphans
```
- the -d is for running the docker comopse in detach mode, so the terminal will not be busy in following the Docker containers logs.
- the --remove-orphans is to remove the unused containers, in this case it will remove the container used to generate the Hornet's private key, that is not needed anymore.

