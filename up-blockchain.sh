
#!/bin/bash

export ROOT_PATH="${ROOT_PATH:-$HOME/workspaces/skripsi}"
export NETWORK_PATH="${NETWORK_PATH:-$ROOT_PATH/fabric-samples/test-network}"

${NETWORK_PATH}/network.sh up