@minLength(3)
@maxLength(23)
@description('The name of the Applicaiton Insight resource')
param applicationInsigthsName string 

@description('Location for the Applicaiton Insigth')
param location string = resourceGroup().location

@description('The kind of used application insight')
param kind string

resource applicaitonInsights 'Microsoft.Insights/components@2020-02-02'={
  name: applicationInsigthsName
  location: location
  kind: kind
  properties:{
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}
output applicationInsightName string = applicaitonInsights.name
output applicationInsightId string = applicaitonInsights.id
