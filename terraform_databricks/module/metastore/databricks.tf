# for Databricks creation
resource "azurerm_databricks_workspace" "example" {
  name                = var.databricks_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.bricks_sku

  tags = {
    Environment = var.environment
  }
}

# for creating storage account
resource "azurerm_storage_account" "storageaccount" {
 name                     = var.storage_account_name
 resource_group_name      = var.resource_group_name
 location                 = var.location
 account_tier             = var.bricks_account_tier #"Premium"
 account_replication_type = var.bricks_account_replication_type #"LRS"
 account_kind             = var.brickd_account_kind #"BlockBlobStorage"
 is_hns_enabled           = "true"

 tags = {
   environment = var.environment
 }
}
#storage container creation
resource "azurerm_storage_container" "storagecontainer" {
 depends_on            = [azurerm_storage_account.storageaccount] 
 name                  = var.storage_container_name
 storage_account_name  = var.storage_account_name
 container_access_type = "private"
}

#databricks access connector
resource "azurerm_databricks_access_connector" "databricsaccess" {
  name                = var.databricks_access_connector_name
  resource_group_name = var.resource_group_name
  location            = var.location 
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}

# for assiging the role to storage account
resource "azurerm_role_assignment" "assign_identity_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.storageaccount.id
  #scope                = var.scope
  role_definition_name = var.role_definition_name #"Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.databricsaccess.identity[0].principal_id
}
