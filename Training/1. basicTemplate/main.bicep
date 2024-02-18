resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'storebicep'
  location: 'westus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'BlobStorage'
}
