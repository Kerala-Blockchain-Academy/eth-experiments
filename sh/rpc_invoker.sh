#!/bin/sh
set -e

execute() {
    chain_id
    block_number
    client_version
}

req_handler() {
    curl -s -H "Content-Type: application/json" --data "$@" "${CHAIN_URL}"
}

res_parser() {
    echo "$@" | jq -r '.result'
}

chain_id() {
    response=$(req_handler '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}')
    echo "Chain ID: $(res_parser "$response")"
    return 0
}

client_version() {
    response=$(req_handler '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":1}')
    echo "Client: $(res_parser "$response")"
    return 0
}

block_number() {
    response=$(req_handler '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}')
    echo "Block Number: $(res_parser "$response")"
    return 0
}

CHAIN_URL="http://127.0.0.1:8545"

execute
