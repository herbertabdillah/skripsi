#!/bin/bash

export ROOT_PATH="${ROOT_PATH:-$HOME/workspaces/skripsi}"
export NETWORK_PATH="${NETWORK_PATH:-$ROOT_PATH/fabric-samples/test-network}"

cd ${ROOT_PATH}/explorer
docker compose down
docker volume rm explorer_pgdata || true
docker volume rm explorer_walletstore || true
docker compose up -d

cd ${ROOT_PATH}/skripsi-nginx
docker compose up -d

cd ${ROOT_PATH}/ais
docker compose up -d