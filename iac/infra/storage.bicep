@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the Storage Account. Defaults to a unique hashed string prefized with "petspotr-"')
param accountName string = 'petspotr${uniqueString(resourceGroup().id)}'

@description('Name of the blob container used for images. Defaults to "images".')
param imagesContainerName string = 'images'

@description('Name of the blob container used for pet state. Defaults to "pets".')
param petsContainerName string = 'pets'

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: accountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  resource blobServices 'blobServices' = {
    name: 'default'

    resource images 'containers' = {
      name: imagesContainerName
    }

    resource state 'containers' = {
      name: petsContainerName
    }
  }

}

output storageAccountId string = storage.id
output storageAccountName string = storage.name
output imagesContainerId string = storage::blobServices::images.id
output containerName string = storage::blobServices::state.name
