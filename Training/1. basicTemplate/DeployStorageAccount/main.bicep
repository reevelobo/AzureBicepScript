resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stbicepcourcedev005'
  location: 'westus'
  sku: {
    name: 'Premium_LRS'
  }
  kind: 'StorageV2'
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stauditcoursedev005'
  location: 'westus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
