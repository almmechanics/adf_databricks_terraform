locals {
  private_databricks_name     = format("%sprivatedatabricks", local.prefix)
  public_databricks_name      = format("%spublicdatabricks", local.prefix)
  workspace_name              = format("%sworkspace", local.prefix)
  managed_resource_group_name = format("%s-managed-rg", azurerm_resource_group.logging.name)
  db_logging_name             = format("%s_logging", local.workspace_name)
}

data "azuread_client_config" "current" {}
# data "databricks_current_user" "current" {
#   depends_on = [
#     azurerm_databricks_workspace.databricks
#   ]
# }

data "azuread_user" "current" {
  object_id = data.azuread_client_config.current.object_id
}

# data "databricks_user" "current" {
#   provider  = databricks
#   user_name = data.databricks_current_user.current.user_name
# }

#  resource "databricks_user" "current" {
#    provider     = databricks
#    user_name    = data.azuread_client_config.current.user_name
#    display_name = "Admin user"
#  }

# resource "databricks_user_role" "current" {
#   provider = databricks
#   user_id  = data.databricks_user.current.id
#   role     = "account_admin"
# }

data "databricks_node_type" "smallest" {
  local_disk = false
  depends_on = [azurerm_databricks_workspace.databricks]

}

# data "databricks_spark_version" "latest_lts" {
#   long_term_support = true
#   depends_on        = [azurerm_databricks_workspace.databricks]
# }



resource "azurerm_databricks_workspace" "databricks" {
  name                        = local.workspace_name
  resource_group_name         = azurerm_resource_group.logging.name
  location                    = azurerm_resource_group.logging.location
  sku                         = "premium"
  managed_resource_group_name = local.managed_resource_group_name
}


# module "databricks_logging" {
#   source         = "./databricks_logging"
#   ai_key         = module.core_logging.ai_key
#   oms_id         = module.core_logging.oms_id
#   oms_key        = module.core_logging.oms_key
#   ai_jar_version = var.ai_jar_version
#   ai_core        = abspath(format("%s/%s", path.module, local.ai_logging))
#   ai_logging     = abspath(format("%s/%s", path.module, local.ai_logging))
#   depends_on = [
#     data.external.download_ai_core,
#     data.external.download_ai_logging,
#     azurerm_databricks_workspace.databricks,
#   module.core_logging]
# }

# resource "databricks_library" "applicationinsights" {
#   cluster_id = databricks_cluster.my-cluster.id
#   pypi {
#     package = "applicationinsights==0.11.10"
#   }
#   depends_on = [azurerm_databricks_workspace.databricks]
# }


resource "databricks_cluster" "my-cluster" {
  spark_version = "11.3 LTS"#data.databricks_spark_version.latest_lts.id
  node_type_id  = data.databricks_node_type.smallest.id
  num_workers   = 1
  cluster_name  = "logging cluster"

  # init_scripts {
  #   dbfs {
  #     destination = module.databricks_logging.cluster_init_script
  #   }
  # }
  depends_on = [azurerm_databricks_workspace.databricks]
}


# resource "databricks_cluster_policy" "fair_use" {
#   name = "Fair Use Policy"
#   definition = jsonencode({
#     "dbus_per_hour" : {
#       "type" : "range",
#       "maxValue" : 20
#     },
#     "autotermination_minutes" : {
#       "type" : "fixed",
#       "value" : 10,
#       "hidden" : true
#     },
#     "custom_tags.Department" : {
#       "type" : "fixed",
#       "value" : "test",
#       "hidden" : true
#     }
#   })
# }

# resource "databricks_permissions" "use_policy" {
#     cluster_policy_id = databricks_cluster_policy.fair_use.id

#     access_control {
#         group_name = databricks_group.marketing.display_name
#         permission_level = "CAN_USE"
#     }
# }

resource "databricks_group" "auto" {
  display_name = "Automation"
  depends_on   = [azurerm_databricks_workspace.databricks]
}

resource "databricks_group" "eng" {
  display_name = "Engineering"
  depends_on   = [azurerm_databricks_workspace.databricks]
}

resource "databricks_group" "ds" {
  display_name = "Data Science"
  depends_on   = [azurerm_databricks_workspace.databricks]
}




resource "databricks_instance_pool" "this" {
  instance_pool_name                    = "Reserved Instances"
  idle_instance_autotermination_minutes = 60
  node_type_id                          = data.databricks_node_type.smallest.id
  min_idle_instances                    = 0
  max_capacity                          = 10
  depends_on                            = [azurerm_databricks_workspace.databricks]
}


# resource "databricks_permissions" "pool_usage" {
#   instance_pool_id = databricks_instance_pool.this.id

#   access_control {
#     group_name       = databricks_group.auto.display_name
#     permission_level = "CAN_ATTACH_TO"
#   }

#   access_control {
#     group_name       = databricks_group.eng.display_name
#     permission_level = "CAN_MANAGE"
#   }
#   depends_on = [azurerm_databricks_workspace.databricks]
# }

# resource "databricks_permissions" "cluster_usage" {
#   cluster_id = databricks_cluster.my-cluster.cluster_id

#   access_control {
#     group_name       = databricks_group.auto.display_name
#     permission_level = "CAN_ATTACH_TO"
#   }

#   access_control {
#     group_name       = databricks_group.eng.display_name
#     permission_level = "CAN_RESTART"
#   }

#   access_control {
#     group_name       = databricks_group.ds.display_name
#     permission_level = "CAN_MANAGE"
#   }
#   depends_on = [azurerm_databricks_workspace.databricks]
# }