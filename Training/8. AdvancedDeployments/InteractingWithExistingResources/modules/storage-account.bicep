@description('Location for the resources')
param location string = 'westeurope'

@description('Tags for the storage account')
param tags object = {}

@minLength(3)
@maxLength(23)
@description('The name of the audit storage accont')
param storageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountsku string = 'Standard_LRS'

@description('The type of storage account')
@allowed([
  'blobStorage'
  'StorageV2'
])
param storageAccountKind string = 'StorageV2'

@description('Names of the container to Deploy.')
param containerNames array =[]


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountsku
  }
  kind: storageAccountKind
  properties:{
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageAccount
}

// resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
//   name: 'data'
//   parent: blobService
//   properties: {
//     publicAccess: 'None'
//   }
// }
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for containerName in containerNames: {
  name: containerName
  parent: blobService
  properties: {
    publicAccess: 'None'
  }
}
]
output storageAccountName string = storageAccount.name
output storageaccountId string = storageAccount.id

