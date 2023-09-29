# =========================================================
# variables

variable "location" {
    type        = string
    default     = "West Europe"
    description = "Location for all the resources"
}

variable "environment" {
    type        = string
    default     = "dev"
    description = "Environment of deployed resource"
}

variable "tags" {
    type        = map(string)
    default     = {
        distribution = "spoke"
        environment = "development"
        application = "function_app_premium_linux_python_01"
    }
    description = "Tags to apply to resources groupe and resources"
}

variable "resource-group-name" {
    type        = string
    default     = "rg-fnpremlpy-training-dev-001"
    description = "Resource group name"
}


variable "storage-account-name" {
    type        = string
    default     = "stafnpremlpydev001"
    description = "Storage acocunt name"
}


variable "application-insight-name" {
    type        = string
    default     = "appi-fnpremlpy-dev-001"
    description = "Application insight name"
}


variable "app-service-plan-name" {
    type        = string
    default     = "asp-fnpremlinux-dev-001"
    description = "App service plan name"
}


variable "function-app-name" {
    type        = string
    default     = "funcapp-python01-dev-001"
    description = "Function App name"
}


variable "function-name" {
    type        = string
    default     = "func-py01-dev-001"
    description = "Function name"
}