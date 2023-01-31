@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the Storage Account. Defaults to a unique hashed string prefized with "petspotr-"')
param accountName string = 'petspotr${uniqueString(resourceGroup().id)}'

@description('Name of the blob container. Defaults to "images".')

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: accountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  resource blobServices 'blobServices' = {
    name: 'default'

    resource container 'containers' = {
      name: 'images'
      properties: {
        publicAccess: 'None'
      }
    }
  }
}

output storageAccountId string = storage.id
output storageAccountName string = storage.name
output imagesContainerId string = storage::blobServices::container.id
