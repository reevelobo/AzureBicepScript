@description('Location for the resources')
param location string = resourceGroup().location

@description('Tags for the storage account')
param tags object = {}

@minLength(3)
@maxLength(23)
@description('The name of the audit storage accont')
param storageAccountName string

@minLength(3)
@maxLength(23)
@description('The name of the audit storage accont')
param sftpStorageAccountName string

@minLength(3)
@maxLength(23)
@description('The name of the App Service Plan')
param appServicePlanName string

@description('Name of function App Resource')
param functionAppName string


@description('Name of the SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountsku string = 'Standard_LRS'

@description('Name of the SKU')
@allowed([
  'S1'
  'B1'
])
param appServicePlansku string = 'B1'

@minLength(3)
@maxLength(23)
@description('The name of the Applicaiton Insight resource')
param applicationInsigthsName string 

@description('The kind of used application insight')
param applicationInsightskind string

@secure()
@description('API Key')
param apiKey string

resource storageAccountRef 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

var storageAccountConnectString = 'DefaultEndpointsPortocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountRef.listKeys().keys[0].value}'



module storageAccount 'Module/storage-account.bicep'={
  name: 'deploy-${storageAccountName}'
  params: {
    location:location
    storageAccountName: storageAccountName
    storageAccountsku: storageAccountsku
    tags: tags
  }
}
module sftpStorageAccount 'Module/storage-account.bicep' ={
  name: 'deploy-${sftpStorageAccountName}'
  params: {
    location: location
    storageAccountName: sftpStorageAccountName
    storageAccountsku: storageAccountsku
    isSftpEnable:true
    tags:tags
  }
}

module applicationInsights 'Module/application-insights.bicep'={
  name: 'deploy-${applicationInsigthsName}'
  params: {
    applicationInsigthsName: applicationInsigthsName
    kind: applicationInsightskind
    location:location
  }
}

module appServicePlan 'Module/app-service-plan.bicep'={
  name: 'deploy-${appServicePlanName}'
  params: {
    appServicePlanName: appServicePlanName
    appServicePlansku : appServicePlansku
    location:location 
  }
}

resource functionApp 'Microsoft.Web/sites@2023-01-01'={
  name: functionAppName
  location: location
  tags:tags
  kind:'functionapp' 
  identity:{
    type:'SystemAssigned'
  }
  properties:{
    serverFarmId:appServicePlan.outputs.appServicePlanId
    httpsOnly:true
    siteConfig:{
      windowsFxVersion: 'DOTNETCORE|LTS'
      appSettings:[
        {
          name:'FUNCTIONS_EXTENSION_VERSION'
          value:'~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'ApiKey'
          value: apiKey
        }
        {
          name: 'AzureWebJobStorage'
          value: storageAccountConnectString
        }
      ]
    }

  }
}
output storageAccountName string = storageAccount.outputs.storageAccountName
output sftpStorageAccount string = sftpStorageAccount.outputs.storageAccountName
output applicationInsights string = applicationInsights.outputs.applicationInsightName
output appServicePlan string = appServicePlan.outputs.appServicePlanName
