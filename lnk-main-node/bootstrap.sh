#!/bin/bash

if [ ! -f .env ]; then
  echo "No .env file found. Please see README.md for more details"
fi

if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit
fi

./cleanup.sh

# Pull latest images
docker compose pull

# Prepare all directories
mkdir -p data

mkdir -p data/grafana
mkdir -p data/prometheus
mkdir -p data/letsencrypt

mkdir -p data/hornet
mkdir -p data/hornet/privatedb
mkdir -p data/hornet/snapshots
mkdir -p data/hornet/p2pstore

mkdir -p data/hornet_dashboard

mkdir -p data/wasp
mkdir -p data/indexer

mkdir -p data/participation
# mkdir -p data/database_legacy
# mkdir -p data/database_chrysalis

mkdir -p data/coordinator
mkdir -p data/coordinator/state

if [ ! -f data/wasp/users.json ]; then
  echo "{}" >> data/wasp/users.json
fi

if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 data
fi
