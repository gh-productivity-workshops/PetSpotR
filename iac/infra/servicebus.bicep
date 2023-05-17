@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the service bus namespace.')
param namespaceName string = 'petspotr-${uniqueString(resourceGroup().id)}'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: namespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }

  resource keda 'AuthorizationRules' = {
    name: 'KEDA'
    properties: {
      rights: [
        'Manage'
        'Listen'
        'Send'
      ]
    }
  }

  resource dapr 'AuthorizationRules' = {
    name: 'Dapr'
    properties: {
      rights: [
        'Manage'
        'Listen'
        'Send'
      ]
    }
  }

}

output serviceBusId string = namespace.id
output serviceBusAuthRuleName string = '${namespace.name}/${namespace::keda.name}'
output daprAuthRuleName string = namespace::dapr.name
