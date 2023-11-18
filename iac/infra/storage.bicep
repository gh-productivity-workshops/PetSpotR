// Parameter for the location of the storage account, named "location"

// Parameter for the name of the storage account
param location string = resourceGroup().location
param storageAccountName string

// Storage account for storing images
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// Output for the storage account name
output storageAccountName string = storageAccount.name
