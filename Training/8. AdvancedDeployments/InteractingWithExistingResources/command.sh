az group create -l westus -n bicep-course  
az deployment group create --subscription insomnia --resource-group bicep-course --name deployment  --template-file main.bicep --parameters "@main.parameters.json"
