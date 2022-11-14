

locals {
  prefix     = format("%s%s%03d", var.prefix, var.suffix, var.instance)
  ai_core    = format("applicationinsights-core-%s.jar", var.ai_jar_version)
  ai_logging = format("applicationinsights-logging-log4j1_2-%s.jar", var.ai_jar_version)
}

data "azurerm_client_config" "current" {
}

data "external" "download_ai_core" {
  program = ["pwsh", "${path.module}/pwsh/Download-File.ps1", path.module, local.ai_core, var.ai_jar_version]
}

data "external" "download_ai_logging" {
  program = ["pwsh", "${path.module}/pwsh/Download-File.ps1", path.module, local.ai_logging, var.ai_jar_version]
}


module "core_logging" {
  source              = "./core_logging"
  location            = azurerm_resource_group.logging.location
  resource_group_name = azurerm_resource_group.logging.name
  prefix              = local.prefix
  log_retention_days  = var.log_retention_days

}