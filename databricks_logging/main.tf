terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "= 0.2.8"
    }
  }
}

locals {
  init_script      = "${path.module}/appinsights_logging_init.sh"
  ai_core          = format("${path.module}/applicationinsights-core-%s.jar", var.ai_jar_version)
  ai_logging       = format("${path.module}/applicationinsights-logging-log4j1_2-%s.jar", var.ai_jar_version)
  dbfs_ai_core     = format("/databricks/appinsights/applicationinsights-core-%s.jar", var.ai_jar_version)
  dbfs_ai_logging  = format("/databricks/appinsights/applicationinsights-logging-log4j1_2-%s.jar", var.ai_jar_version)
  dbfs_init_script = "/databricks/appinsights/appinsights_logging_init.sh"
}

data "external" "download_ai_core" {
  program = ["pwsh", "${path.module}/pwsh/Download-File.ps1", path.module, local.ai_core, var.ai_jar_version]
}

data "external" "download_ai_logging" {
  program = ["pwsh", "${path.module}/pwsh/Download-File.ps1", path.module, local.ai_logging, var.ai_jar_version]
}

resource "databricks_dbfs_file" "ai_core" {
  source               = lookup(data.external.download_ai_core.result, "library")
  content_b64_md5      = md5(filebase64(pathexpand(local.ai_core)))
  path                 = local.dbfs_ai_core
  overwrite            = true
  mkdirs               = true
  validate_remote_file = true

  depends_on = [
    data.external.download_ai_core
  ]
}

resource "databricks_dbfs_file" "ai_logging" {
  source               = lookup(data.external.download_ai_logging.result, "library")
  content_b64_md5      = md5(filebase64(pathexpand(local.ai_logging)))
  path                 = local.dbfs_ai_logging
  overwrite            = true
  mkdirs               = true
  validate_remote_file = true

  depends_on = [
    data.external.download_ai_logging
  ]
}

data "template_file" "databricks_init" {
  template = templatefile("${path.module}/appinsights_logging_init.tpl", {
    ai_key     = var.ai_key
    oms_id     = var.oms_id
    oms_key    = var.oms_key
    ai_version = var.ai_jar_version
  })
}

resource "local_file" "databricks_init" {
  content  = data.template_file.databricks_init.rendered
  filename = local.init_script
}

resource "databricks_dbfs_file" "dbfs_init_script" {
  source               = local.init_script
  content_b64_md5      = md5(base64encode(data.template_file.databricks_init.rendered))
  path                 = local.dbfs_init_script
  overwrite            = true
  mkdirs               = true
  validate_remote_file = true

  depends_on = [
    local_file.databricks_init,
    databricks_dbfs_file.ai_core,
    databricks_dbfs_file.ai_logging
  ]
}