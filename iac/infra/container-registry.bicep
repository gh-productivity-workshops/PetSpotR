@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the container registry. Defaults to unique hashed ID prefixed with "petspotr"')
param registryName string = 'petspotr${uniqueString(resourceGroup().id)}'

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: registryName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    anonymousPullEnabled: true
  }
}

output registryId string = acr.id
output registryName string = acr.name
