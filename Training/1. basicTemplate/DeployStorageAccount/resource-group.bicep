targetScope = 'subscription'


resource resourceGorup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-bicep-creation'
  location: 'westus'
}
