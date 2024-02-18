az login --tenant "de0f6c16-8aa7-4cce-950f-1881052ab947"   --use-device-code
# Create Resource Group [Azure Cli]
az deployment group create --resource-group bicep-course 
az deployment group create --name demoRGDeployment --resource-group bicep-course --template-file main.bicep 
