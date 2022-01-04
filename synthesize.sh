#!/bin/bash

set -e

touch service.config

echo "Initializing the infrastructure project..."
pushd {TEMPLATE_SERVICE_HYPHEN_NAME}-infrastructure
npm install
npm install -g ts-node
npm install -g aws-cdk
cdk bootstrap --require-approval=never

echo "Synthesizing your infrastructure project..."
cdk synth --json > ../cdk_synth.json
popd
