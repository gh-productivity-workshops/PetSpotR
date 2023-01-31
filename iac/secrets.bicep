@description('Azure Service Bus namespace authorization rule name')
param serviceBusAuthorizationRuleName string

@description('Azure Storage Accont name')
param storageAccountName string

@description('Azure CosmosDB account name')
param cosmosAccountName string

@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr-${uniqueString(resourceGroup().id)}'

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}
var kubeConfig = aksCluster.listClusterAdminCredential().kubeconfigs[0].value

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2022-08-15' existing = {
  name: cosmosAccountName
}

resource daprAuthRule 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2022-01-01-preview' existing = {
  name: serviceBusAuthorizationRuleName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

import 'kubernetes@1.0.0' with {
  kubeConfig: kubeConfig
  namespace: 'default'
}

resource serviceBusSecret 'core/Secret@v1' = {
  metadata: {
    name: 'servicebus'
  }
  stringData: {
    connectionString: daprAuthRule.listKeys().primaryConnectionString
  }
}

resource storageSecret 'core/Secret@v1' = {
  metadata: {
    name: 'storage'
  }
  stringData: {
    accountKey: storageAccount.listAccountSas().accountSasToken
  }
}

resource cosmosSecret 'core/Secret@v1' = {
  metadata: {
    name: 'cosmos'
  }
  stringData: {
    accountKey: cosmosAccount.listConnectionStrings().connectionStrings[0].connectionString
  }
}
