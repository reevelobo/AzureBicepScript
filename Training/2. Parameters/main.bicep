@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account Sku')
param storageAccountSku string

@description('Location of the Storage Account')
param location string = 'westus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
