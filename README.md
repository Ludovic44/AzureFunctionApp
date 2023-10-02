# AzureFunctionApp

![Azure Function App](https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/functions-1?resMode=sharp2&op_usm=1.5,0.65,15,0&wid=2880&qlt=100&fit=constrain)

## Sommaire
1. [Public](https://github.com/Ludovic44/AzureFunctionApp/tree/main#public)
1. [Contenu du repository](https://github.com/Ludovic44/AzureFunctionApp/tree/main#contenu-du-repository)
1. [Sources](https://github.com/Ludovic44/AzureFunctionApp/tree/main#sources)


## Public

- [x] Niveau 100 - Débutant
- [x] Niveau 200 - Junior
- [ ] Niveau 300 - Confirmé
- [ ] Niveau 400 - Expert


## Contenu du repository

Ce repository contient les scripts IaC Terraform ainsi que le code vous permettant de créer votre première Function App et son code associé.
Qu'il sagisse
* d'un Consumption plan ou
* d'un Premium plan,
 
que ce soit un App Service plan
* Linux ou
* Windows,

que votre runtime soit
* Powershell core ou 
* Python,

déclenché sur un trigeer
* HTTP ou
* Blob storage

tout y est.


### Terraform_ConsumptionPlan_Windows
Le répertoire [Terraform_ConsumptionPlan_Windows](https://github.com/Ludovic44/AzureFunctionApp/tree/main/Terraform_ConsumptionPlan_Windows) contient les script Terraform vous permettant de créer une Azure Function App sur un Consumption plan Windows.


### Terraform_PremiumPlan_Linux
Le répertoire [Terraform_PremiumPlan_Linux](https://github.com/Ludovic44/AzureFunctionApp/tree/main/Terraform_PremiumPlan_Linux) contient les script Terraform vous permettant de créer une Azure Function App sur un Premium plan Linux.


### FunctionCode_Powershell
Le répertoire [FunctionCode_Powershell]([Terraform_PremiumPlan_Linux](https://github.com/Ludovic44/AzureFunctionApp/tree/main/FunctionCode_Powershell) contient la structure de dossier et le code vous permettant de déclencher une **Function** en **Powershell core** lors d'un ajout de fichier sur un blob storage.


### FunctionCode_Python
Le répertoire [FunctionCode_Python](https://github.com/Ludovic44/AzureFunctionApp/tree/main/FunctionCode_Python)  contient la structure de dossier et le code vous permettant de déclencher une **Function** en **Python** lors d'un appel **GET** ou **POST** en HTTP.



## Sources
En complément, vouz trouverez des informations sur Azure Functions sur les sites ci-dessous :
- [azurerm_function_app_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_function)
- [Terraform: Deploy Azure Function App with Consumption Plan](https://build5nines.com/terraform-deploy-azure-function-app-with-consumption-plan/)
- 