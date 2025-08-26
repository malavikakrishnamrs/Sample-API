provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-webapp-demo"
  location = "East US"
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "asp-webapp-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# App Service
resource "azurerm_linux_web_app" "webapp" {
  name                = "demo-webapp-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
