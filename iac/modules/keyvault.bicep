@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the Key Vault. Defaults to a unique hashed string prefized with "petspotr-"')
param vaultName string = 'petspotr-${uniqueString(resourceGroup().id)}'

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: vaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    enabledForDeployment: true
  }
}

output vaultId string = vault.id
