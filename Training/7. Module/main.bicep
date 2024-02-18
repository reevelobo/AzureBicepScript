@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountNames array


@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account Sku')
param storageAccountSku string

@description('Location of the Storage Account')
param location string = 'westus'

module storageAccount 'module/storage-account.bicep' = [for storageAccountName in storageAccountNames :{
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}]

output storageAccounts array = [for i in range(0, length(storageAccountNames)): {
  name: storageAccount[i].outputs.storageAccountName
  id: storageAccount[i].outputs.storageAccountId
}]



