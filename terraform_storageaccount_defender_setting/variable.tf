variable "location" {
}

variable "resource_group_name" {
}


variable "env" {
}

#variable "str_subnet_id" {
#}

variable "tags" {
}

variable "str_name" {
}


variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
}

variable "skuname" {
  description = "The SKUs supported by Microsoft Azure Storage. Valid options are Premium_LRS, Premium_ZRS, Standard_GRS, Standard_GZRS, Standard_LRS, Standard_RAGRS, Standard_RAGZRS, Standard_ZRS"
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account"
}

variable "assign_identity" {
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
}

#variable "enable_advanced_threat_protection" {
#  description = "Boolean flag which controls if advanced threat protection is enabled."
#}

#variable "network_rules" {
#  description = "Network rules restricing access to the storage account."
#}

variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string }))
}


variable "file_shares" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, quota = number }))
}


variable "queues" {
  description = "List of storages queues"
  type        = list(string)
}

variable "tables" {
  description = "List of storage tables."
  type        = list(string)
}
