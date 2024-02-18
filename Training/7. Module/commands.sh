az login --tenant "de0f6c16-8aa7-4cce-950f-1881052ab947"   --use-device-code


az deployment group create --subscription insomnia 
--resource-group bicep-course --name deployment --mode complete --template-file main.bicep --parameters @main.parameters.json