// Application -----------------------------------------

@description('Name of the container registry. Defaults to unique hashed ID prefixed with "petspotr"')
param registryName string = 'petspotr${uniqueString(resourceGroup().id)}'

@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr-${uniqueString(resourceGroup().id)}'

@description('Name of the Service Bus Authorization Rule Name')
param serviceBusAuthRuleName string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' existing = {
  name: registryName
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
}

resource serviceBusAuthRule 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2022-01-01-preview' existing = {
  name: serviceBusAuthRuleName
}

module frontend 'app/frontend.bicep' = {
  name: 'frontend'
  params: {
    containerRegistry: containerRegistry.properties.loginServer
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
}

module backend 'app/backend.bicep' = {
  name: 'backend'
  params: {
    containerRegistry: containerRegistry.properties.loginServer
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
    serviceBusNamespaceConnectionString: serviceBusAuthRule.listKeys().primaryConnectionString
  }
}

module ingress 'app/ingress.bicep' = {
  name: 'ingress'
  params: {
    HTTPApplicationRoutingZoneName: aksCluster.properties.addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    kubeConfig: aksCluster.listClusterAdminCredential().kubeconfigs[0].value
  }
}
