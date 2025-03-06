#!/bin/bash

display_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -h, --help     Display this help message"
    echo "  --l1, --L1     Only clean directories related to L1 (tangle)"
    echo "  --l2, --L2     Only clean directories related to L2 (wasp & indexer)"
    exit 0
}

clean_L1() {
    rm -rf data/hornet/privatedb
    rm -rf data/hornet/snapshots
    rm -rf data/hornet/p2pstore/peers
    rm -rf data/coordinator
    rm -rf data/participation
}

clean_L2() {
    rm -rf data/indexer
    rm -rf data/wasp/chains
    rm -rf data/wasp/dkshares
    rm -rf data/wasp/p2pstore
    rm -rf data/wasp/snap
    rm -rf data/wasp/wal
}

# Check if running as root or with sudo
if [[ "$OSTYPE" != "darwin"* && "$EUID" -ne 0 ]]; then
    echo "Please run as root or with sudo"
    exit 1
fi

# Parse command-line options
if [[ $# -gt 1 ]]; then
    echo "Error: Only one parameter is allowed."
    display_help
    exit 1
elif [[ $# -eq 0 ]]; then
    # If no flags provided, remove all directories
    docker compose down --remove-orphans
    clean_L1
    clean_L2
else
    case "$1" in
        -h|--help)
            display_help
            ;;
        --l1|--L1)
            clean_L1
            ;;
        --l2|--L2)
            docker compose down wasp-dashboard wasp -t 10 --remove-orphans
            clean_L2
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            ;;
    esac
fi