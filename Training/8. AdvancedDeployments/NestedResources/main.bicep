@description('Location for the resources')
param location string = 'westus'

@description('Tags for the storage account')
param tags object = {}

@minLength(3)
@maxLength(23)
@description('The name of the audit storage accont')
param storageAccountName string

@minLength(3)
@maxLength(23)
@description('The name of the audit storage accont')
param auditStorageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountsku string

module storageAccount 'modules/storage-account.bicep'={
  name: storageAccountName
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountsku: storageAccountsku
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageaccountId
