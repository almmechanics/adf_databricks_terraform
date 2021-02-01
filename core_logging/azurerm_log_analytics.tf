# Generate random text for a unique storage account name
locals {
  azurerm_log_analytics_workspace_name = format("%s-oms", var.prefix)
}

resource "azurerm_log_analytics_workspace" "oms" {
  name                = local.azurerm_log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
}

# resource "azurerm_log_analytics_solution" "oms" {
#   solution_name         = local.oms_adf_solution
#   location              = data.azurerm_resource_group.logging.location
#   resource_group_name   = data.azurerm_resource_group.logging.name
#   workspace_resource_id = azurerm_log_analytics_workspace.oms.id
#   workspace_name        = azurerm_log_analytics_workspace.oms.name

#   plan {
#     publisher = "Microsoft"
#     product   = "OMSGallery/AzureDataFactoryAnalytics"
#   }
# }