# Create resource group [PowerShell]
New-AzResourceGroup -Location westus -Name bicep-course
# Deploy bicep template [PowerShell]
New-AzResourceGroupDeployment -Subscription "insomnia"  -ResourceGroup "bicep-course" -Name ps1_deployment -TemplateFile main.bicep -Parameters "@main.parameters.json"


