@minLength(3)
@maxLength(23)
@description('The name of the App Service Plan')
param appServicePlanName string

param location string

param appServicePlansku string


resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01'={
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlansku
  }
}
output appServicePlanName string = appServicePlan.name
output appServicePlanId string = appServicePlan.id
