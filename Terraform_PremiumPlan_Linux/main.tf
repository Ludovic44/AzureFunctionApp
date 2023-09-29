# =========================================================
# premium plan with app service plan PYTHON (LINUX)

# create resource group
resource "azurerm_resource_group" "functionpremiumlinuxpython" {
  provider = azurerm.subdev001
  name     = var.resource-group-name
  location = var.location

  tags = var.tags
}


# create storage account
resource "azurerm_storage_account" "functionpremiumlinuxpython" {
  provider                 = azurerm.subdev001
  name                     = var.storage-account-name
  resource_group_name      = azurerm_resource_group.functionpremiumlinuxpython.name
  location                 = azurerm_resource_group.functionpremiumlinuxpython.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}


# create app insight
resource "azurerm_application_insights" "functionpremiumlinuxpython" {  
  provider                 = azurerm.subdev001
  name                     = var.application-insight-name 
  resource_group_name      = azurerm_resource_group.functionpremiumlinuxpython.name
  location                 = azurerm_resource_group.functionpremiumlinuxpython.location

  application_type         = "web"

  # https://github.com/terraform-providers/terraform-provider-azurerm/issues/1303
  # tags = {
  #   "hidden-link:${azurerm_resource_group.functionpremiumlinuxpython.id}/providers/Microsoft.Web/sites/func-apppy02-dev-001" = "Resource"
  # }
  tags = merge(var.tags, {
    "hidden-link:${azurerm_resource_group.functionpremiumlinuxpython.id}/providers/Microsoft.Web/sites/${var.function-app-name}" = "Resource"
  })

}


# create app service plan - premium plan
resource "azurerm_service_plan" "functionpremiumlinuxpython" {
  provider                = azurerm.subdev001
  name                    = var.app-service-plan-name
  resource_group_name     = azurerm_resource_group.functionpremiumlinuxpython.name 
  location                = azurerm_resource_group.functionpremiumlinuxpython.location

  sku_name                = "B1"
  os_type                 = "Linux"

  tags = var.tags
}


# create function app
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app
resource "azurerm_linux_function_app" "functionpremiumlinuxpython" {
  provider                     = azurerm.subdev001
  name                         = var.function-app-name
  resource_group_name          = azurerm_resource_group.functionpremiumlinuxpython.name
  location                     = azurerm_resource_group.functionpremiumlinuxpython.location

  service_plan_id              = azurerm_service_plan.functionpremiumlinuxpython.id

  storage_account_name         = azurerm_storage_account.functionpremiumlinuxpython.name
  storage_account_access_key   = azurerm_storage_account.functionpremiumlinuxpython.primary_access_key
  
  https_only                    = true
  functions_extension_version   = "~4"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.functionpremiumlinuxpython.connection_string
    application_insights_key               = azurerm_application_insights.functionpremiumlinuxpython.instrumentation_key
    always_on = true # "Always on" should be enabled for your app to improve function cold start and reliability.
    application_stack {
      python_version = "3.9"
      use_dotnet_isolated_runtime = null
    }
    app_service_logs {
      disk_quota_mb = 50 # This is the limit that restricts file system usage by app diagnostics logs.The default value is 35 MB. Value can range from 25 MB and 100 MB.
      retention_period_days = 3 # by default site diagnostic logs are never deleted
    }
  }

  # app_settings = {
  #   FUNCTIONS_WORKER_RUNTIME        = "dotnet-isolated"
  #   forcedToHaveSecretWhenNotNeeded = ""
  # }

  # https://learn.microsoft.com/en-us/azure/azure-functions/functions-app-settings
  # app_settings = {
  #   APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.functionpremiumlinuxpython.instrumentation_key
  #   APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.functionpremiumlinuxpython.connection_string
  #   # AzureWebJobsDashboard = ""
  #   # AzureWebJobsStorage = ""
  #   FUNCTIONS_EXTENSION_VERSION = "~4"
  #   FUNCTIONS_WORKER_RUNTIME = "python"
  # #   PROPERTY_FILE_PATH = "property"
  # #   SCM_DO_BUILD_DURING_DEPLOYMENT = false
  # #   WEBSITE_RUN_FROM_PACKAGE= "1"
  # }

   tags = var.tags
}


# create function
resource "azurerm_function_app_function" "functionpremiumlinuxpython" {
  provider                  = azurerm.subdev001
  name                      = var.function-name
  function_app_id           = azurerm_linux_function_app.functionpremiumlinuxpython.id
  language                  = "Python"
  test_data                 = jsonencode({
    "name"                  = "Azure"
  })
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}