# ADF and Databricks connectivity

The codebase creates an end-to-end ADF to databricks pipeline with fully integrated logging. 

## Tech Stack

*  `Terraform`
*  `ARM`
*  `DataFactory`
*  `Application Insights`
*  `Log Analytics`

## Usage 

```Terraform
terraform plan -var-file="../secret.tfvars" -out=plan.tfplan
terraform apply plan.tfplan
```

Not included `secrets.tfvars` - you need to supply your own.## Requirements

---
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.31.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | 1.6.2 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.2.3 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.31.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 1.6.2 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_core_logging"></a> [core\_logging](#module\_core\_logging) | ./core_logging | n/a |
| <a name="module_data_storage_external"></a> [data\_storage\_external](#module\_data\_storage\_external) | ./module_storage | n/a |
| <a name="module_data_storage_internal"></a> [data\_storage\_internal](#module\_data\_storage\_internal) | ./module_storage | n/a |
| <a name="module_databricks_logging"></a> [databricks\_logging](#module\_databricks\_logging) | ./databricks_logging | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights_analytics_item.databricks_logging_query](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/application_insights_analytics_item) | resource |
| [azurerm_data_factory.adf](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/data_factory) | resource |
| [azurerm_data_factory_linked_service_data_lake_storage_gen2.external](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/data_factory_linked_service_data_lake_storage_gen2) | resource |
| [azurerm_data_factory_linked_service_data_lake_storage_gen2.internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/data_factory_linked_service_data_lake_storage_gen2) | resource |
| [azurerm_data_factory_pipeline.external_internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/data_factory_pipeline) | resource |
| [azurerm_data_factory_trigger_schedule.external_internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/data_factory_trigger_schedule) | resource |
| [azurerm_databricks_workspace.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/databricks_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.adf](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group_template_deployment.dataset_data_lake_storage_gen2_destination](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_resource_group_template_deployment.dataset_data_lake_storage_gen2_source](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_resource_group_template_deployment.linked_databricks](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_role_assignment.adf_databricks](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.external_adf](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.internal_adf](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.destination](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.source](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/resources/storage_container) | resource |
| [databricks_cluster.my-cluster](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/resources/cluster) | resource |
| [databricks_notebook.adf_calling_databricks](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/resources/notebook) | resource |
| [databricks_notebook.logging_python](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/resources/notebook) | resource |
| [databricks_notebook.logging_scala](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/resources/notebook) | resource |
| [random_id.adf_random](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/id) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/data-sources/client_config) | data source |
| [azurerm_monitor_diagnostic_categories.adf](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_resource_group.logging](https://registry.terraform.io/providers/hashicorp/azurerm/3.31.0/docs/data-sources/resource_group) | data source |
| [databricks_node_type.smallest](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/data-sources/node_type) | data source |
| [databricks_spark_version.latest](https://registry.terraform.io/providers/databricks/databricks/1.6.2/docs/data-sources/spark_version) | data source |
| [local_file.adf_calling_databricks](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [local_file.databricks_logging_query](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [local_file.dataset_data_lake_storage_gen2](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [local_file.linked_databricks](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [local_file.logging_python](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [local_file.logging_scala](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/data-sources/file) | data source |
| [template_file.pipeline_external_internal](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | `number` | `3` | no |
| <a name="input_location"></a> [location](#input\_location) | Common resource group to target | `string` | `"centralus"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | n/a | `number` | `30` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"demo"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | n/a | `string` | `"logging"` | no |

## Outputs

No outputs.
