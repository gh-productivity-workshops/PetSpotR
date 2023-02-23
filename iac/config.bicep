@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr-${uniqueString(resourceGroup().id)}'

@description('Azure Storage Accont name')
param storageAccountName string

@description('Azure CosmosDB account name')
param cosmosAccountName string

@description('Azure Service Bus authorization rule name')
param serviceBusAuthorizationRuleName string

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2022-08-15' existing = {
  name: cosmosAccountName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
}

resource serviceBusAuthorizationRule 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2022-01-01-preview' existing = {
  name: serviceBusAuthorizationRuleName
}

module secrets 'infra/secrets.bicep' = {
  name: 'secrets'
  params: {
    cosmosUrl: cosmosAccount.properties.documentEndpoint
    cosmosAccountKey: cosmosAccount.listKeys().primaryMasterKey
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
    storageAccountKey: storageAccount.listKeys().keys[0].value
    serviceBusConnectionString: serviceBusAuthorizationRule.listKeys().primaryConnectionString
  }
}
