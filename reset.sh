#!/bin/bash

export ROOT_PATH="${ROOT_PATH:-$HOME/workspaces/skripsi}"
export NETWORK_PATH="${NETWORK_PATH:-$ROOT_PATH/fabric-samples/test-network}"

${NETWORK_PATH}/network.sh down || true
${NETWORK_PATH}/network.sh up
${NETWORK_PATH}/network.sh createChannel -c uinjkt
${NETWORK_PATH}/network.sh deployCC -ccn contract -ccp ${ROOT_PATH}/skripsi-contract-go/ -ccl go -c uinjkt

docker volume rm explorer_pgdata || true
docker volume rm explorer_walletstore || true