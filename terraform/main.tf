// Terraform configuration for Azure Container Registry and Container Instance

terraform {
  required_version = ">= 1.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

// Resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

// Container registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

// Container instance
resource "azurerm_container_group" "aci" {
  name                = var.container_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label

  os_type             = "Linux"

  container {
    name   = "django-app"
    image  = "${azurerm_container_registry.acr.login_server}/${var.image_name}:${var.image_tag}"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 8000
      protocol = "TCP"
    }

    environment_variables = {
      DJANGO_SECRET_KEY = var.django_secret_key
      DATABASE_NAME     = var.database_name
      DATABASE_USER     = var.database_user
      DATABASE_PASSWORD = var.database_password
      DATABASE_HOST     = var.database_host
    }
  }

  image_registry_credential {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }
}