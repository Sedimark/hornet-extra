#!/bin/bash

if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit
fi

docker compose down --remove-orphans

rm -Rf privatedb/hornet-extra
rm -Rf privatedb/indexer
#do not delete private/wasp-db or you will lose your entire configuration
rm -Rf snapshots