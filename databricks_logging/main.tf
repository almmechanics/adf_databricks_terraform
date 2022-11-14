locals {
  ai_core          = format("applicationinsights-core-%s.jar", var.ai_jar_version)
  ai_logging       = format("applicationinsights-logging-log4j1_2-%s.jar", var.ai_jar_version)
  dbfs_ai_core     = format("/databricks/appinsights/%s", local.ai_core)
  dbfs_ai_logging  = format("/databricks/appinsights/%s", local.ai_logging)
  dbfs_init_script = "/databricks/appinsights/appinsights_logging_init.sh"
}


resource "databricks_dbfs_file" "ai_core" {
  source = var.ai_core
  path   = local.dbfs_ai_core

}

resource "databricks_dbfs_file" "ai_logging" {

  source = var.ai_logging
  path   = local.dbfs_ai_logging

}

resource "databricks_dbfs_file" "dbfs_init_script" {
  content_base64 = base64encode(
    templatefile("${path.module}/appinsights_logging_init.tpl",
      {
        "ai_key"     = var.ai_key
        "oms_id"    = var.oms_id
        "oms_key"    = var.oms_key
        "ai_version" = var.ai_jar_version
      }
    )    
  )
    
  path   = local.dbfs_init_script

  depends_on = [
    databricks_dbfs_file.ai_core,
    databricks_dbfs_file.ai_logging
  ]
}