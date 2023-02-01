@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the Load Test. Defaults to a unique hashed string prefized with "petspotr-"')
param loadTestName string = 'petspotr-${uniqueString(resourceGroup().id)}'

resource loadTest 'Microsoft.LoadTestService/loadTests@2022-12-01' = {
  name: loadTestName
  location: location
}
