# PetSpotR

[![Build and deploy](https://github.com/Azure-Samples/PetSpotR/actions/workflows/deploy.yaml/badge.svg)](https://github.com/Azure-Samples/PetSpotR/actions/workflows/deploy.yaml)

PetSpotR allows you to use advanced AI models to report and find lost pets. It is a sample application that uses Azure Machine Learning to train a model to detect pets in images.

It also leverages popular open-source projects such as Dapr and Keda to provide a scalable and resilient architecture.

![Logo](./img/logo.svg)

## Architecture

![architecture](./img/architecture.png)

## Deploying this application

1. Ensure you have access to an Azure subscription and the Azure CLI installed
   ```bash
   az login
   az accouunt set --subscription "My Subscription"
   ```
1. Clone this repository
   ```bash
   git clone https://github.com/azure-samples/petspotr.git
   cd petspotr
   ```
1. Deploy the infrastructure
   ```bash
   az deployment group deployment create --resource-group myrg --template-file ./iac/infra.json
   ```
1. Deploy the configuration
   ```bash
   az deployment group deployment create --resource-group myrg --template-file ./iac/config.json
   ```
1. Deploy the application
   ```bash
   az deployment group deployment create --resource-group myrg --template-file ./iac/app.json
   ```
