# =========================================================
# variables

variable "location" {
    type        = string
    default     = "West Europe"
    description = "Location for all the resources"
}

variable "tags" {
    type        = map(string)
    default     = {
        distribution = "spoke"
        environment = "development"
        application = "function_app_consumption_win_powershell_01"
    }
    description = "Tags to apply to resources groupe and resources"
}

variable "resource-group-name" {
    type        = string
    default     = "rg-fnconswps-training-dev-001"
    description = "Resource group name"
}


variable "storage-account-name" {
    type        = string
    default     = "stafnconswpsdev001"
    description = "Storage acocunt name"
}


variable "application-insight-name" {
    type        = string
    default     = "appi-fnconswps-dev-001"
    description = "Application insight name"
}


variable "app-service-plan-name" {
    type        = string
    default     = "asp-fnconswindows-dev-001"
    description = "App service plan name"
}


variable "function-app-name" {
    type        = string
    default     = "funcapp-powershell01-dev-001"
    description = "Function App name"
}


variable "function-name" {
    type        = string
    default     = "func-ps01-dev-001"
    description = "Function name"
}