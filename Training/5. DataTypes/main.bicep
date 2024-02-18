@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@description('Name of the storage account for logging')
param logStorageAccountName string

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

/////////////////////////////////////////////////////////////////////////
// Data Types 
/////////////////////////////////////////////////////////////////////////
// Integers 
@description('The maximum number of storage accounts that can be created in a subscription.')
var maxStorageAccountsPerSubscription = 250

// Array
@description('List of storage account names')
var existingStorageAccountNames = [
  'storageaccountxdc01'
  'storageaccountxfc02'
  'storageaccountxvc03'
]

// object
@description('Storage Account Properties')
var storageAccountProperties = {
  supportsHttpsTrafficOnly: true
  minimumTlsVersion: minimumTlsVersion
}  

// Accessing values of the array and object
var firstStorageAccountName = existingStorageAccountNames[0]
var propertyMinimumTlsVersion = storageAccountProperties.minimumTlsVersion

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: firstStorageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

resource loggingstorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name: existingStorageAccountNames[1]
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

output storageAccountName string= storageAccount.name
output storageAccountId string= storageAccount.id

