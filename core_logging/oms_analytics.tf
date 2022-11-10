locals {
  adf_oms_product    = "AzureDataFactoryAnalytics"
  adf_analytics_name = format("%s(%s)", local.adf_oms_product, azurerm_log_analytics_workspace.oms.name)
}

data "local_file" "oms_analytics" {
  filename = "${path.module}/arm/oms_analytics.json"
}

resource "azurerm_resource_group_template_deployment" "adf_analytics" {
  name                = local.adf_analytics_name
  resource_group_name = var.resource_group_name
  template_content    = data.local_file.oms_analytics.content
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    Name        = local.adf_analytics_name
    WorkspaceId = azurerm_log_analytics_workspace.oms.id
    OMSProduct  = local.adf_oms_product
  })
}
