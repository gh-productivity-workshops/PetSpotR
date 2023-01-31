@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the CosmosDB account. Defaults to a unique hashed string prefized with "petspotr-"')
param accountName string = 'petspotr-${uniqueString(resourceGroup().id)}'

@description('Name of the SQL database. Defaults to "petspotr".')
param databaseName string = 'petspotr'

@description('Name of the container. Defaults to "pets".')
param containerName string = 'pets'

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2022-02-15-preview' = {
  name: accountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
    publicNetworkAccess: 'Enabled'
  }

  resource database 'sqlDatabases' = {
    name: databaseName
    properties: {
      resource: {
        id: databaseName
      }
    }

    resource container 'containers' = {
      name: containerName
      properties: {
        resource: {
          id: containerName
          partitionKey: {
            paths: [
              '/partitionKey'
            ]
            kind: 'Hash'
          }
          indexingPolicy: {
            indexingMode: 'consistent'
            automatic: true
            includedPaths: [
              {
                path: '/*'
              }
            ]
            excludedPaths: [
              {
                path: '/_etag/?'
              }
            ]
          }
          conflictResolutionPolicy: {
            mode: 'LastWriterWins'
            conflictResolutionPath: '/_ts'
          }
        }
      }
    }

  }

}
