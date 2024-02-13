# Local Declarations
locals {
  account_tier             = (var.account_kind == "FileStorage" ? "Premium" : split("_", var.skuname)[0])
  account_replication_type = (local.account_tier == "Premium" ? "LRS" : split("_", var.skuname)[1])
}

resource "azurerm_storage_account" "storage_account" {
  name                      = var.str_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = true
  is_hns_enabled           = true
  min_tls_version           = var.min_tls_version
  assign_identity                   = var.assign_identity
  soft_delete_retention             = var.soft_delete_retention
  file_shares                       = var.file_shares
  containers_list                   = var.containers_list
  queues                            = var.queues
  tables                            = var.tables
  lifecycles                        = var.lifecycles
  tags                              = var.tags

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }

  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention
    }
  }
}

# Storage Advanced Threat Protection 

#resource "azurerm_advanced_threat_protection" "atp" {
#  target_resource_id = azurerm_storage_account.storage_account.id
#  enabled            = var.enable_advanced_threat_protection
#}

resource "azurerm_template_deployment" "defender_settings" {
  name                = "yibfinaltest"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  template_body = jsonencode({
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {},
    "resources": [
      {
        "type": "Microsoft.Security/DefenderForStorageSettings",
        "apiVersion": "2022-12-01-preview",
        #"apiVersion": "2015-06-15",
        "name": "current",
        "properties": {
          "isEnabled": true,
          "malwareScanning": {
            "onUpload": {
              "isEnabled": true,
              "capGBPerMonth": 5000
            }
          },
          "sensitiveDataDiscovery": {
            "isEnabled": true
          },
          "overrideSubscriptionLevelSettings": true
        },
        "scope": "[resourceId('Microsoft.Storage/storageAccounts', '${var.str_name}')]"
      }
    ]
  })
}

# Storage Container Creation

resource "azurerm_storage_container" "container" {
  count                 =   length(var.containers_list) 
  name                  = var.containers_list[count.index].name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.containers_list[count.index].access_type
}

# Storage Fileshare Creation

resource "azurerm_storage_share" "fileshare" {
  count                =   length(var.file_shares)
  name                 = var.file_shares[count.index].name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.file_shares[count.index].quota
}

# Storage Tables Creation

resource "azurerm_storage_table" "tables" {
  count                = length(var.tables)
  name                 = var.tables[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}

# Storage Queue Creation

resource "azurerm_storage_queue" "queues" {
  count                = length(var.queues)
  name                 = var.queues[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}
