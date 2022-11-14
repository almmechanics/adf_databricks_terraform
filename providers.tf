terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.6.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }

    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }

    external = {
      source  = "hashicorp/external"
      version = "2.2.3"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }


    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }

  }
}


provider "azurerm" {
  skip_provider_registration = false
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


data "azurerm_subscription" "current" {
}


provider "databricks" {
  host = azurerm_databricks_workspace.databricks.workspace_url
}
