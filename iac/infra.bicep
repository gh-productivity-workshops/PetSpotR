// Infrastructure ----------------------------------------------------

targetScope = 'subscription'

param location string = 'westus2'

@description('Which mode to deploy the infrastructure. Defaults to cloud, which deploys everything. The mode dev only deploys the resources needed for local development.')
@allowed([
  'cloud'
  'dev'
])
param mode string = 'cloud'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'build-lab'
  location: location
}

module storage 'infra/storage.bicep' = {
  name: 'storage'
  scope: resourceGroup
  params: {
    location: location
  }
}

module servicebus 'infra/servicebus.bicep' = if (mode == 'cloud') {
  name: 'servicebus'
  scope: resourceGroup
  params: {
    location: location
  }
}

module aks 'infra/aks.bicep' = if (mode == 'cloud') {
  name: 'aks'
  scope: resourceGroup
  params: {
    location: location
  }
}

output clusterName string = aks.outputs.aksCluster
output storageAccountName string = storage.outputs.storageAccountName
output serviceBusAuthorizationRuleName string = servicebus.outputs.serviceBusAuthRuleName
