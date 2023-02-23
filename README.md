# PetSpotR

[![Build and deploy](https://github.com/Azure-Samples/PetSpotR/actions/workflows/deploy.yaml/badge.svg)](https://github.com/Azure-Samples/PetSpotR/actions/workflows/deploy.yaml)

PetSpotR allows you to use advanced AI models to report and find lost pets. It is a sample application that uses Azure Machine Learning to train a model to detect pets in images.

It also leverages popular open-source projects such as Dapr and Keda to provide a scalable and resilient architecture.

![Logo](./img/logo.svg)

## Architecture

![architecture](./img/architecture.png)

## Running locally

1. Install the [Dapr CLI](https://docs.dapr.io/getting-started/install-dapr-cli/)
1. Initialize Dapr
   ```bash
   dapr init
   ```
1. Configure your Dapr images component for Windows or Mac
   1. Open ./iac/dapr/local/images.yaml
   1. Uncomment the appropriate section for your OS, and comment out the other section
1. Run the backend
   ```bash
   cd src/backend
   dapr run --app-id backend --app-port 6002 --components-path ../../iac/dapr/local -- python app.py
   ```
1. Run the frontend
   ```bash
   cd src/frontend/PetSpotR
   dapr run --app-id frontend --app-port 5114 --components-path ../../../iac/dapr/local -- dotnet watch
   ```
1. Navigate to http://localhost:5114

## Deploying this application via CLI

1. Ensure you have access to an Azure subscription and the Azure CLI installed
   ```bash
   az login
   az account set --subscription "My Subscription"
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
1. Get AKS credentials
   ```bash
   az aks get-credentials --resource-group myrg --name petspotr
   ```
1. Install Helm Charts
   ```bash
   helm repo add dapr https://dapr.github.io/helm-charts/
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo update
   helm upgrade dapr dapr/dapr --install --version=1.10 --namespace dapr-system --create-namespace --wait
   helm upgrade keda kedacore/keda --install --version=2.9.4 --namespace keda --create-namespace --wait
   ```
1. Log into Azure Container Registry
   You can get your registry name from your resource group in the Azure Portal
   ```bash
   az acr login --name myacr
   ```
1. Build and push containers
   ```bash
   docker build -t myacr.azurecr.io/backend:latest ./src/backend
   docker build -t myacr.azurecr.io/frontend:latest ./src/frontend
   docker push myacr.azurecr.io/petspotr:latest
   docker push myacr.azurecr.io/frontend:latest
   ```
1. Deploy the application
   ```bash
   az deployment group deployment create --resource-group myrg --template-file ./iac/app.json
   ```
1. Get your frontend URL
   ```bash
   kubectl get svc
   ```
1. Navigate to your frontend URL
