# =========================================================
# consumption plan POWERSHELL (WINDOWS)

# create resource group
resource "azurerm_resource_group" "functionconsumptionwinpowershell" {
  provider        = azurerm.subdev001  
  name            = var.resource-group-name
  location        = var.location

  tags = var.tags
}


# create storage account
resource "azurerm_storage_account" "functionconsumptionwinpowershell" {
  name                     = "stafnconswpsdev001"
  provider                 = azurerm.subdev001  
  resource_group_name      = azurerm_resource_group.functionconsumptionwinpowershell.name
  location                 = azurerm_resource_group.functionconsumptionwinpowershell.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}


# create app insight
resource "azurerm_application_insights" "functionconsumptionwinpowershell" {
  provider            = azurerm.subdev001  
  name                = var.application-insight-name
  resource_group_name = azurerm_resource_group.functionconsumptionwinpowershell.name
  location            = azurerm_resource_group.functionconsumptionwinpowershell.location

  application_type    = "web"

  # https://github.com/terraform-providers/terraform-provider-azurerm/issues/1303
  tags = merge(var.tags, {
    "hidden-link:${azurerm_resource_group.functionconsumptionwinpowershell.id}/providers/Microsoft.Web/sites/${var.function-app-name}" = "Resource"
  })
}


# create service plan - consumption plan
resource "azurerm_service_plan" "functionconsumptionwinpowershell" {
  provider            = azurerm.subdev001
  name                = var.app-service-plan-name
  resource_group_name = azurerm_resource_group.functionconsumptionwinpowershell.name
  location            = azurerm_resource_group.functionconsumptionwinpowershell.location
  sku_name            = "Y1"
  os_type             = "Windows"

  tags = var.tags
}


# create function app
resource "azurerm_windows_function_app" "functionconsumptionwinpowershell" {
  provider                   = azurerm.subdev001  
  name                       = var.function-app-name
  location                   = azurerm_resource_group.functionconsumptionwinpowershell.location
  resource_group_name        = azurerm_resource_group.functionconsumptionwinpowershell.name

  service_plan_id            = azurerm_service_plan.functionconsumptionwinpowershell.id

  storage_account_name       = azurerm_storage_account.functionconsumptionwinpowershell.name
  storage_account_access_key = azurerm_storage_account.functionconsumptionwinpowershell.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.functionconsumptionwinpowershell.connection_string
    application_insights_key               = azurerm_application_insights.functionconsumptionwinpowershell.instrumentation_key

    application_stack {
      powershell_core_version = "7"
    }
    use_32_bit_worker = false

    # application_stack {
    #   powershell_core_version = "7.2" # when used use_32_bit_worker=false setting dosn't work
    # }
    # use_32_bit_worker = true
  }

  tags = var.tags
}


# create function
resource "azurerm_function_app_function" "functionconsumptionwinpowershell" {
  provider                  = azurerm.subdev001
  name                      = var.function-name
  function_app_id           = azurerm_windows_function_app.functionconsumptionwinpowershell.id
  language                  = "PowerShell"
  enabled                   = false
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