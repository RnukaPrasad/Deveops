# data "azurerm_databricks_workspace" "workspaceName" {
#   name                = var.databricks_workspace_name
#   resource_group_name = var.resource_group_name
# }

locals {
  databricks_resource_id    = azurerm_databricks_workspace.example.id
  resource_regex            = "(?i)subscriptions/(.+)/resourceGroups/(.+)/providers/Microsoft.Databricks/workspaces/(.+)"
  subscription_id           = regex(local.resource_regex, local.databricks_resource_id)[0]
  resource_group            = regex(local.resource_regex, local.databricks_resource_id)[1]
  databricks_workspace_name = regex(local.resource_regex, local.databricks_resource_id)[2]
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  databricks_workspace_host = data.azurerm_databricks_workspace.this.workspace_url
  databricks_workspace_id   = data.azurerm_databricks_workspace.this.workspace_id
  prefix                    = replace(replace(lower(data.azurerm_resource_group.this.name), "rg", ""), "-", "")
  name                      = var.metastore_name
}

data "azurerm_resource_group" "this" {
  name = local.resource_group
}

data "azurerm_client_config" "current" {
}

data "azurerm_databricks_workspace" "this" {
  name                = local.databricks_workspace_name
  resource_group_name = local.resource_group
}

output "workspace_id" {
  value = data.azurerm_databricks_workspace.this.workspace_id
}
