@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the AKS cluster. Defaults to a unique hash prefixed with "petspotr-"')
param clusterName string = 'petspotr'

@description('The size of the Virtual Machine.')
param agentVMSize string = 'standard_d2s_v3'

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 3

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' = {
  name: clusterName
  location: location
  properties: {
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: 0
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    dnsPrefix: '${clusterName}-dns'
    enableRBAC: true

    // Enable HTTP Application Routing for devlopment purposes
    addonProfiles: {
      httpApplicationRouting: {
        enabled: true
      }
    }

  }
  identity: {
    type: 'SystemAssigned'
  }
}

output aksCluster string = aksCluster.name
