@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr-${uniqueString(resourceGroup().id)}'

@description('Azure Service Bus namespace authorization rule name')
param serviceBusAuthorizationRuleName string

@description('Azure Service Bus namespace authorization rule name')
param serviceBusNamespaceName string

@description('Azure Storage Accont name')
param storageAccountName string

@description('Azure CosmosDB account name')
param cosmosAccountName string

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}

module secrets 'infra/secrets.bicep' = {
  name: 'secrets'
  params: {
    cosmosAccountName: cosmosAccountName
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
    serviceBusAuthorizationRuleName: serviceBusAuthorizationRuleName
    serviceBusNamespaceName: serviceBusNamespaceName
    storageAccountName: storageAccountName
  }
}
