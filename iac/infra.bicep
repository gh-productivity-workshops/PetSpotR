// Infrastructure ----------------------------------------------------

param location string = resourceGroup().location

@description('Which mode to deploy the infrastructure. Defaults to cloud, which deploys everything. The mode dev only deploys the resources needed for local development.')
@allowed([
  'cloud'
  'dev'
])
param mode string

module storage 'infra/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
  }
}

module vault 'infra/keyvault.bicep' = {
  name: 'vault'
  params: {
    location: location
  }
}

module registry 'infra/container-registry.bicep' = {
  name: 'registry'
  params: {
    location: location
  }
}

module aml 'infra/aml.bicep' = {
  name: 'aml'
  params: {
    location: location
    containerRegistryId: registry.outputs.registryId
    keyVaultId: vault.outputs.vaultId
    storageAccountId: storage.outputs.storageAccountId
  }
}

module servicebus 'infra/servicebus.bicep' = if (mode == 'cloud') {
  name: 'servicebus'
  params: {
    location: location
  }
}

module cosmos 'infra/cosmosdb.bicep' = if (mode == 'cloud') {
  name: 'cosmos'
  params: {
    location: location
  }
}

module aks 'infra/aks.bicep' = if (mode == 'cloud') {
  name: 'aks'
  params: {
    location: location
  }
}

module loadTest 'infra/loadtest.bicep' = if (mode == 'cloud') {
  name: 'loadtest'
  params: {
    location: location
  }
}
