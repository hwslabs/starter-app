#!/bin/bash

deleteParameter() {
    echo "Deleting paremeter \"$1\"..."
    aws ssm delete-parameter --name "$1"
}

getParameter() {
  echo "Retrieving parameter \"$1\"..."
  aws ssm get-parameter --name "$1" | jq --raw-output .Parameter.Value
}

deleteSourceCredentials() {
  echo "Deleting GitHub oAuth token from CodeBuild..."
  aws codebuild delete-source-credentials --arn "$1"
}

deleteSecretIfExists() {
    echo "Checking if secret \"$1\" exists..."
    count=$(aws secretsmanager list-secrets | jq --arg name "$1" -c '[.SecretList[] | select(.Name == $name)] | length')

    if [ "$count" -ge 1  ]
    then
        echo "Secret exists..."
        echo "Deleting secret \"$1\" that was used in the infra..."
        aws secretsmanager delete-secret --secret-id "$1"
        echo "Secret deleted successfully..."
    else
        echo "Secret was not found..."
    fi
}

echo "Tearing down the app infrastructure in AWS..."
pushd {TEMPLATE_SERVICE_HYPHEN_NAME}-infrastructure
npm install
npm install -g ts-node
npm install -g aws-cdk
cdk destroy --force

echo "Cleaning up infra package..."
npm run clean
popd

echo "Retrieving CodeBuild credentials ARN..."
credentialsArn=$(getParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-build/github/access-token/arn)
deleteSourceCredentials "$credentialsArn"

echo "Deleting all parameters used..."
deleteParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-build/github/access-token/arn

deleteParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/notifications/email/primary-email

deleteParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/sources/github/user

deleteParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/sources/github/repo

deleteParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/sources/github/branch

#deletePParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/notifications/slack/workspace-id

#deletePParameter /{TEMPLATE_SERVICE_HYPHEN_NAME}/code-pipeline/notifications/slack/channel-id

deleteSecretIfExists /{TEMPLATE_SERVICE_HYPHEN_NAME}/rds/cluster/root/password
