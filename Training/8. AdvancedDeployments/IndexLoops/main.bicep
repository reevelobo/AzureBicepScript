@description('Location for the resources')
param location string = 'westus'

@description('Tags for the storage account')
param tags object = {}

@description('Role Assignment Names')
param role string = 'bicep-assigned-role'

@description('Role Assignment ID')
param roleAssigmentID string

@description('Group ID to assign the Role')
param adGroupID string

@description('storage Account to be assigned')
param storageAccountNames array

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

var auditStorageAccountContainers = [
  'data'
  'logs'
]

module storageAccount 'modules/storage-account.bicep'={
  name: storageAccountName
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountsku: storageAccountsku
    containerNames: auditStorageAccountContainers
  }
}

module roleAssignment 'modules/role-assignment.bicep'={
  name: 'deploy-role-assignments'
  params: {
    adGroupId: adGroupID
    roleAssignmentId: roleAssigmentID
    storageAccountNames: storageAccountNames
  }
  dependsOn:[
    storageAccount
  ]
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageaccountId
