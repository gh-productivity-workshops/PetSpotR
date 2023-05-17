// Application -----------------------------------------

@description('URL of the container registry. Defaults to "petspotr.azurecr.io"')
param registryUrl string = 'petspotr.azurecr.io'

@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr'

@description('Azure Storage Account name')
param storageAccountName string = 'petspotr${uniqueString(resourceGroup().id)}'

@description('Azure Service Bus authorization rule name')
param serviceBusAuthorizationRuleName string = 'petspotr-${uniqueString(resourceGroup().id)}/Dapr'


resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
}

resource serviceBusAuthorizationRule 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2022-01-01-preview' existing = {
  name: serviceBusAuthorizationRuleName
}

module frontend 'app/frontend.bicep' = {
  name: 'frontend'
  params: {
    containerRegistry: registryUrl
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
}

module backend 'app/backend.bicep' = {
  name: 'backend'
  params: {
    containerRegistry: registryUrl
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
}

module ingress 'app/ingress.bicep' = {
  name: 'ingress'
  params: {
    HTTPApplicationRoutingZoneName: aksCluster.properties.addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
}

module secrets 'app/secrets.bicep' = {
  name: 'secrets'
  params: {
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
    storageAccountName: storageAccount.name
    storageAccountKey: storageAccount.listKeys().keys[0].value
    serviceBusConnectionString: serviceBusAuthorizationRule.listKeys().primaryConnectionString
  }
}
