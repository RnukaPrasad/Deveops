#for creating metastore
resource "databricks_metastore" "metastore" {
  depends_on = [ data.local_file.accesstokenfile ]
  name          = var.metastore_name
  storage_root  = format("abfss://%s@%s.dfs.core.windows.net/",
    var.storage_container_name,var.storage_account_name)
  force_destroy = true
  
}

#for creating metastore data access
resource "databricks_metastore_data_access" "metastore_data_access" {
  #depends_on   = [ databricks_metastore.metastore ]
  depends_on   = [databricks_metastore_assignment.default_metastore]
  metastore_id = databricks_metastore.metastore.id
  name         = var.metastore_label
  azure_service_principal {
    directory_id   = var.tenant_id
    application_id = var.client_id
    client_secret  = var.client_secret
  }
  is_default   = true
}

# for metastore assignment
resource "databricks_metastore_assignment" "default_metastore" {
  #depends_on           = [ databricks_metastore_data_access.metastore_data_access ]
  depends_on   = [ databricks_metastore.metastore ]
  workspace_id         = data.azurerm_databricks_workspace.this.workspace_id 
  metastore_id         = databricks_metastore.metastore.id
  default_catalog_name = var.default_metastore_default_catalog_name
}

data "azapi_resource" "this" {
  type      = "Microsoft.Databricks/accessConnectors@2022-04-01-preview"
  name  = var.databricks_access_connector_name
  parent_id = data.azurerm_resource_group.this.id
  
}

# data "azurerm_storage_container" "this" {
#     name  = var.storage_container_name
#     storage_account_name    = var.storage_account_name
  
# }

# data "azurerm_storage_account" "this" {
#   name                     = var.storage_account_name
#   resource_group_name      = data.azurerm_resource_group.this.name
# }
