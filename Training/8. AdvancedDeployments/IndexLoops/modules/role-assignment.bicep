


@description('Name of the Storage Account')
param storageAccountNames array

@description('ID of the AD group for Role Assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string


resource role 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing ={
  name: roleAssignmentId
}

resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' existing= [for storageAccountName in storageAccountNames: {
  name: storageAccountName
  scope:resourceGroup('bicep-course')
}]
// resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' ={
//   name: guid(storageAccountName, role.id, adGroupId)
//   scope:storageAccount
//   properties: {
//     principalId: role.id
//     roleDefinitionId: adGroupId
//   }
// }
resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =[for i in range(0,length(storageAccountNames)):{
  name: guid(storageAccounts[i].id, role.id, adGroupId)
  properties: {
    principalId: role.id
    roleDefinitionId: adGroupId
  }
}]
