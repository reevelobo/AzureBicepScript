# Bicep training structure
## Introduction (ppt)
### IaC
### Introduction to Azure Bicep and ARM templates

## Setting Up Environment (ppt)
#### Installing Azure CLI 
    az --version
    az bicep version
    
#### VS Code Extensions 
    azure tools
    bicep

## Bicep Templates (ppt)

#### Creating Template 
    - create a simple file 
    - required properties 
#### Compiling Azure bicep to ARM templates
    - Why is compiling to arm necessary ?
        - debugging complicated issue 
        - 2 ways 
            - Using extension 
            - az bicep build --file main.bicep
#### Decompiling ARM template 
    - can be useful when migrating arm to bicep.
    - az bicep decompile --file main.bicep.json
    - Not always perfect since there might be some feature in ARM that is not yet implemented in Bicep.
#### Creating a resource group 
    - Target Scope by default is a resource group.
    - 

## Bicep Deployment 
#### Deploying using Azure CLI 
	
#### Azure Deployment Modes (ppt)

**Incremental (default)**
- Keeps existing resources and adds new ones.
- Cant Track changes lack of state 
- Updating resources depends on the name. 
		
**Complete**
- Everything in bicep file should be in RG.
- Anything in RG not belonging to the bicep file - Should not exist 
- Destructive in nature.
- Will find non-existing bicep resources in RG and delete them.
- Incremental is better - completed is destructive and dangerous if you make mistakes.
- Useful for clean up and keeping only required resources.
	
#### Previewing Azure bicep deployment changes
**what-if**
- Can be used in a dev env to find out exactly what is going to change 
- Can be used in Production pipelines as a fail-safe to know exactly what is going to change.
- Can be used for approvals before a change takes place.
					
## Parameters, variables and Output 
### Introduction 
		
PARAMETERS 
- Parameters allow us to inject values into our bicep template.
- Reducing duplication and increasing reusability.
		
VARIABLES
- Helps us store data in a template.
- Reduce any duplication we already have.
		
OUTPUTS
- Helps us get data post-deployment
- we will see different ways to use them.
		
DATA TYPES
- Deep dive into different datatypes.
	
### Parameters 
- Increases reusability of the bicep template
- Parameter syntax param
- Default values 
- Annotations
    - description
    - min and max length - restricts the length
    - allowed - Gives users allowed values to be used. 
    - metadata 
    - Secure 
- Deployment of the template using a parameter file.
    <h5>Method 1<h5/>
    - generate a Parameters file (recommended - cleaner)
    <h5>Method 2<h5/>
    - directly in the deployment command.

### Variables 
- When data is repeated in multiple places it can be turned into a variable.
- syntax - var 

### Output
- Syntax - output
- Useful when executing modules 
```
output storageAccountId string= storageAccount.id
```

### Data Types 
- Strings 
- Booleans 
- Integers 
- Array 
    - []
    - An important thing to note is that in bicep we don't use comma, we use line breaks - same for objects. 
    - You can have mixed arrays where you can add integers boolean etc
- Objects 
    - {}
    - Accessing the values of these objects 
    - Nested Objects are possible.

## Bicep Functions
- Bicep functions are a great way of creating powerful and dynamic bicep templates.
- They enable us to process and manipulate data and help us control the flow of our bicep deployment.
- Practical examples of how we can leverage them.

### Array 
#### First
- Syntax: `first(array)`
#### Contains 
- Syntax: `contains(array, itemToFind)`
#### Add Element
- Syntax: `add(array, itemToAdd)`
#### Remove Element
- Syntax: `remove(array, indexToRemove)`
#### Empty
- Syntax: `empty(array)`
#### Split
- Syntax: `split(inputString, delimiter)`
#### Concat
- Syntax: `concat(string1, string2, string3...)`
#### Union
- Syntax: `union(array1, array2, array3...)`
- Duplication Not allowed 

### Strings 
#### String Interpolation 
- Syntax: `${expression}`
- Example: `var uniqueString = ' myStore-${storageAccountName}-contoso'`
#### Casing 
-  Syntax: `toLower(string)` | `toUpper(string)`
-  Example: `var storageAccountName = toLower(uniqueString)`
#### Trim 
- Syntax: `trim(string)`
- Example: `var storageAccountName = trim(uniqueString)`
#### Substring 
- Syntax: `substring(string, startIndex, length)`
- Example: `var shortName = substring(storageAccountName, 0, 15)`
#### Length 
- Syntax: `length(string)`
- Example: `var locationLength = length('westus')`
#### Replace 
- Syntax: `replace(originalString, oldValue, newValue)`
- Example: `var updatedString = replace(storageAccountName, 'contoso', 'fabrikam')`
#### Base64
- Syntax: `base64(string)`
- Example: `var base64String = base64('Hello World!')`.
#### Base64ToString
- Syntax: `base64ToString(base64Value)`
- Example: `var base64Decoded = base64ToString(base64String)`
#### Contains
- Syntax: `contains(stringToSearch, stringToFind)`


### Data Conversion 
- Syntax: `int(value)` | `bool(value)` | `string(value)` | `float(value)`
- Exmaple: `var intValue = int('4')`
- Example: `var boolValue = bool('true')`
- Example: `var stringValue = string(10)`
- Example: `var floatValue = float(3.14)`




### Object 
#### Intersection
- Common values are returned 
- Syntax: `intersection(array1, array2, array3...)`
#### Json
- Converts a valid Json string to an object
- Syntax: `json(value)`

### Scope Functions 
#### Get resource group details
- Syntax: `resourceGroup()`
- Example: `var rgName = resourceGroup().name`

#### Get subscription details
- Syntax: `subscription()`
- Example: `var subId = subscription().subscriptionId`

#### Get deployment details
- Syntax: `deployment()`
- Example: `var deploymentName = deployment().name`

### Resource Function 
#### Storage Account Custom function 
**List Keys**
- Example: `var storageAccountKey = storageAccount.listKeys().keys[0]` 

### Loading Files External Files 
- File gets automatically parsed
- Syntax: `loadJsonContent(filePath)`
- Example: `var storageAccountKeys = loadJsonContent('storageAccountKeys.json')`


## Advanced Array Manipulation Functions 
### Lambda functions
- [Filter](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-lambda#filter)
- [Map](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-lambda#map)
- [Reduce](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-lambda#reduce)
- [Sort](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-lambda#sort)


## Modules 
- Modules are a great way of breaking down our bicep templates into reusable components.
- They can be used across multiple deployments and even different directories.
- You can use parameters in modules that you pass from the parent template.
- If you want to have conditional resources within your module you can do so by using condition property in the module.
(ppt)

- Bicep Allows you to organize your templates into modules. This makes it easier for developers to manage complex templates by breaking them down into smaller, more manageable templates.

- Let's apply this to our bicep template. We have two storage accounts and have individual resources for each one, we could modularise our template by creating a module for the storage account and then use that module in our main template. 

- In this example, we will also explore how we can use a loop to create multiple storage Accounts.


## Linting

- The first stage of linting can be done using the bicep extenstion during development.
- Code linting can also be done as a add step by compiling to ARM template in Pipeline.
- In addition to the above you can use [ARM-TTK](https://github.com/Azure/arm-ttk) to test the created ARM template
- Steps To Test
    - Build ARM template 
    - Navigate to arm-ttk folder and import the module.
    ```Import-Module .\arm-ttk.psd1```
    - Run the following command to test the template.
    ```Test-AzTemplate -TemplatePath.\azuredeploy.json```

- Run Time validation 
    - This can be achieved using validation deployment mode.

