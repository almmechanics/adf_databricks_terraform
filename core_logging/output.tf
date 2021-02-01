output "ai_key" {
  value     = azurerm_application_insights.ai.instrumentation_key
  sensitive = true
}

output "ai_id" {
  value     = azurerm_application_insights.ai.id
  sensitive = true
}

output "oms_id" {
  value     = azurerm_log_analytics_workspace.oms.id
  sensitive = true
}

output "oms_key" {
  value     = azurerm_log_analytics_workspace.oms.primary_shared_key
  sensitive = true
}