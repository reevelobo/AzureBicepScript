# Create resource group [PowerShell]
New-AzResourceGroup -Location westus -Name bicep-course
# Deploy bicep template [PowerShell]
New-AzResourceGroupDeployment `
    -Name ps1_deployment `
    -ResourceGroupName bicep-course `
    -TemplateFile main.bicep




    