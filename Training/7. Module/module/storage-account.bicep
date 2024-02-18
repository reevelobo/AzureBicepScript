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


var storageAccountKind = 'StorageV2'
var minimumTlsVersion = 'TLS1_2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties:{
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountName string= storageAccount.name
output storageAccountId string= storageAccount.id
