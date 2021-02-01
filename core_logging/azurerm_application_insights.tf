locals {
  azurerm_application_insights_name = format("%s-ai", var.prefix)
}

resource "azurerm_application_insights" "ai" {
  name                = local.azurerm_application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
