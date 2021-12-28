# Rails Deployer

## Overview

This directory contains a simple starter pack written for a Ruby on Rails server.
You can find detailed instructions for building and running example from below

- ** Deployer ** for Ruby on Rails on AWS. This project was created from a template.
- For details, see the template [project on github](https://gitlab.com/hwslabs/starter-app).

## Package Structure

The workspace is organized into the following top-level folders:

- [{TEMPLATE_SERVER_REPO_NAME}]({TEMPLATE_SERVER_REPO_NAME}): Rails HTTP server
- [{TEMPLATE_SERVICE_HYPHEN_NAME}-infrastructure]({TEMPLATE_SERVICE_HYPHEN_NAME}-infrastructure): Infrastructure-as-code to deploy and run server remotely on AWS.
- [deploy.sh](deploy.sh): Script to initialize and deploy the infrastructure
- [teardown.sh](teardown.sh): Script to destroy the infrastructure and cleanup

## Deploy and destroy from macOS
<details>
  <summary>Install Homebrew</summary>

Download and install Homebrew:

  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
</details>

<details>
  <summary>Install nvm</summary>

Install latest version of nvm:

  ```sh
  brew install nvm
  ```
</details>
<details>
  <summary>Install any version of Node</summary>

Install latest version of node:

  ```sh
  nvm install node
  ```

or any specific version of node:

  ```sh
  nvm install 14.17.6
  ```
</details>
<details>
<summary>Configure AWS CLI</summary>

Follow the instructions from [AWS CDK Getting Started](https://docs.aws.amazon.com/cdk/latest/guide/getting_started.html#getting_started_prerequisites)
to configure your AWS account

</details>
<details>
<summary>Deploy & Teardown</summary>

 To intialize and deploy, run:

  ```sh
  ./deploy.sh
  ```
  
  To teardown and cleanup, run:

  ```sh
  ./teardown.sh
  ```

</details>
