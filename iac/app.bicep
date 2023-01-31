// Application -----------------------------------------

@description('Name of the container registry. Defaults to unique hashed ID prefixed with "petspotr"')
param registryName string = 'petspotr${uniqueString(resourceGroup().id)}'

@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr-${uniqueString(resourceGroup().id)}'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' existing = {
  name: registryName
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' existing = {
  name: clusterName
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
  }
}
