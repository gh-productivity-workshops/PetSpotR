// Infrastructure ----------------------------------------------------

param location string = resourceGroup().location

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

module servicebus 'infra/servicebus.bicep' = {
  name: 'servicebus'
  params: {
    location: location
  }
}

module cosmos 'infra/cosmosdb.bicep' = {
  name: 'cosmos'
  params: {
    location: location
  }
}

module aks 'infra/aks.bicep' = {
  name: 'aks'
  params: {
    location: location
  }
}

module loadTest 'infra/loadtest.bicep' = {
  name: 'loadtest'
  params: {
    location: location
  }
}
