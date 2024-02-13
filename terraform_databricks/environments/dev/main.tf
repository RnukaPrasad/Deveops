data "azurerm_resource_group" "resgrp" {
  name = var.resource_group_name
}

module "metastore" {
  source                                  = "../../module/metastore"
  databricks_workspace_name         = var.databricks_workspace_name
  bricks_sku                        = var.bricks_sku
  databricks_access_connector_name  = var.databricks_access_connector_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  environment                       = var.environment
  role_definition_name              = var.role_definition_name
  storage_account_name              = var.storage_account_name
  storage_container_name            = var.storage_container_name
  bricks_account_tier               = var.bricks_account_tier
  bricks_account_replication_type   = var.bricks_account_replication_type
  brickd_account_kind               = var.brickd_account_kind
  metastore_name                          = var.metastore_name
  metastore_label                         = var.metastore_label
  tenant_id                               = var.tenant_id
  client_id                               = var.client_id
  client_secret                           = var.client_secret
  default_metastore_default_catalog_name  = var.default_metastore_default_catalog_name
  catalog_name                            = var.catalog_name
  cluster_name                            = var.cluster_name
  spark_version                           = var.spark_version
  cluster_autotermination_minutes         = var.cluster_autotermination_minutes
  cluster_num_workers                     = var.cluster_num_workers
  cluster_data_security_mode              = var.cluster_data_security_mode
  subscription_id                         = var.subscription_id
  resource_type                           = var.resource_type
}
