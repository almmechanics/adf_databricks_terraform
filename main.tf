terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "= 0.2.8"
    }
    local = {
      version = "~> 2.0.0"
    }

    azurerm = {
      version = "=2.45.1"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

locals {
  prefix = format("%s%s%03d", var.prefix, var.suffix, var.instance)
}

data "azurerm_client_config" "current" {}

module "core_logging" {
  source              = "./core_logging"
  location            = data.azurerm_resource_group.logging.location
  resource_group_name = data.azurerm_resource_group.logging.name
  prefix              = local.prefix
  log_retention_days  = var.log_retention_days
}