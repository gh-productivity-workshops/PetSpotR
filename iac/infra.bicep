// Infrastructure ----------------------------------------------------

param location string = resourceGroup().location

module storage 'infra/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    accountName: 'petspotr'
  }
}

module vault 'infra/keyvault.bicep' = {
  name: 'vault'
  params: {
    location: location
    vaultName: 'petspotr'
  }
}

module registry 'infra/container-registry.bicep' = {
  name: 'registry'
  params: {
    location: location
    registryName: 'petspotr'
  }
}

module aml 'infra/aml.bicep' = {
  name: 'aml'
  params: {
    location: location
    workspaceName: 'petspotr'
    containerRegistryId: registry.outputs.registryId
    keyVaultId: vault.outputs.vaultId
    storageAccountId: storage.outputs.storageAccountId
  }
}

module servicebus 'infra/servicebus.bicep' = {
  name: 'servicebus'
  params: {
    location: location
    namespaceName: 'petspotr'
  }
}

module cosmos 'infra/cosmosdb.bicep' = {
  name: 'cosmos'
  params: {
    accountName: 'petspotr'
    location: location
  }
}

var clusterName = 'petspotr'
module aks 'infra/aks.bicep' = {
  name: 'aks'
  params: {
    location: location
    clusterName: clusterName
  }
}

// Secrets -------------------------------------------------------------

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}

module secrets 'infra/secrets.bicep' = {
  name: 'secrets'
  params: {
    cosmosAccountName: cosmos.outputs.cosmosName
    storageAccountName: storage.outputs.storageAccountName
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
  dependsOn: [
    aks
    servicebus
  ]
}
