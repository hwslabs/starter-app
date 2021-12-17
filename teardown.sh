#!/bin/bash

echo "Tearing down the app infrastructure in AWS..."
pushd {TEMPLATE_SERVICE_HYPHEN_NAME}-app-infrastructure
npm install
npm install -g ts-node
npm install -g aws-cdk
cdk destroy --force

echo "Cleaning up infra package..."
npm run clean
popd
