#!/bin/bash

if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit
fi

# Cleanup if necessary
if [ -d "privatedb" ] || [ -d "snapshots" ]; then
  ./cleanup.sh
fi

# Create snapshot
mkdir -p snapshots/hornet-extra
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 snapshots
fi
#docker compose run create-snapshots

# Prepare database directory for hornet-extra
mkdir -p privatedb/hornet-extra
#mkdir -p privatedb/state
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 privatedb
fi

# Duplicate snapshot for all nodes
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 snapshots
fi

# Prepare database directory
mkdir -p privatedb/indexer
mkdir -p privatedb/wasp-db
if [[ "$OSTYPE" != "darwin"* ]]; then
  chown -R 65532:65532 privatedb
fi
