variable "access_key"{
  default = ""
}
variable "location" {
  default = ""
}

variable "tags" {
  default = ""
}

variable "env" {
  default = ""
}

variable "subscription_id" {
  description = "subscription id"
}

variable "tenant_id" {
  description = "tenant id"
}

variable "client_id" {

  default = ""

}


variable "client_secret" {

  default =""

}

variable "str_name" {
    type = any
    default = {
                "backend" = {
                    "name" = ""
                }
            }
}

variable "resource_group_name" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "terraform"
}

variable "storagename" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "yokogawa123567455"
}

variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
}

variable "skuname" {
  description = "The SKUs supported by Microsoft Azure Storage. Valid options are Premium_LRS, Premium_ZRS, Standard_GRS, Standard_GZRS, Standard_LRS, Standard_RAGRS, Standard_RAGZRS, Standard_ZRS"
  default     = "Standard_LRS"
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account"
  default     = "TLS1_2"
}

variable "assign_identity" {
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
  default     = true
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  default     = 30
}

#variable "enable_advanced_threat_protection" {
#  description = "Boolean flag which controls if advanced threat protection is enabled."
#  default     = true
#}

variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ bypass = list(string), ip_rules = list(string), subnet_ids = string })
  default     = null
}

variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string, str_backup_name=string }))
 # default     = [{name = "influx",access_type = "private", str_backup_name="backup"}]
  default = []
}


variable "file_shares" {
  description = "List of fileshares to create and their access levels."
  type        = list(object({ name = string, quota = number }))
  #  default     = [{name = "elastic", quota = 50 }]
  default = []
}


variable "queues" {
  description = "List of storages queues"
  type        = list(string)
  default     = []
}

variable "tables" {
  description = "List of storage tables."
  type        = list(string)
  default     = []
}
variable "lifecycles" {
  description = "Configure Azure Storage firewalls and virtual networks"
  type        = list(object({ prefix_match = set(string), tier_to_cool_after_days = number, tier_to_archive_after_days = number, delete_after_days = number, snapshot_delete_after_days = number }))
  default     = []
}
variable "databricks_workspace_name" {}
variable "bricks_sku" {}
variable "databricks_access_connector_name" {}
variable "role_definition_name" {}
variable "environment" {}
variable "storage_account_name" {}
variable "storage_container_name" {}
variable "bricks_account_tier" {}
variable "bricks_account_replication_type" {}
variable  "brickd_account_kind" {}
variable "catalog_name" {}
variable "metastore_name" {}
variable "metastore_label" {}
variable "default_metastore_default_catalog_name" {}
variable "cluster_name" {}
variable "cluster_autotermination_minutes" {}
variable "cluster_num_workers" {}
variable "cluster_data_security_mode" {}      
variable "resource_type" {}
variable "spark_version" {}
