#!/bin/bash

# npx caliper launch manager --caliper-workspace ./ --caliper-networkconfig networks/fabric/test-network.yaml --caliper-benchconfig ./src/config.yaml --caliper-flow-only-test --caliper-fabric-gateway-enabled
npx caliper launch manager --caliper-workspace . --caliper-benchconfig src/config.yaml --caliper-networkconfig test-network.yaml