param location string = resourceGroup().location

module storage 'modules/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    accountName: 'petspotr'
  }
}

module vault 'modules/keyvault.bicep' = {
  name: 'vault'
  params: {
    location: location
    vaultName: 'petspotr'
  }
}

module registry 'modules/container-registry.bicep' = {
  name: 'registry'
  params: {
    location: location
    registryName: 'petspotr'
  }
}

module aml 'modules/aml.bicep' = {
  name: 'aml'
  params: {
    location: location
    workspaceName: 'petspotr'
    containerRegistryId: registry.outputs.registryId
    keyVaultId: vault.outputs.vaultId
    storageAccountId: storage.outputs.storageAccountId
  }
}

module servicebus 'modules/servicebus.bicep' = {
  name: 'servicebus'
  params: {
    location: location
    namespaceName: 'petspotr'
  }
}

module aks 'modules/aks.bicep' = {
  name: 'aks'
  params: {
    location: location
    clusterName: 'petspotr'
  }
}
