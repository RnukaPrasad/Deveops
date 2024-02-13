terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
      #version = "=0.4.0"
    }
    # azurerm = {
    #   source = "hashicorp/azurerm"
    #   version = "=3.70.0"
    # }
    databricks = {
      source = "databricks/databricks"
      #version = "1.24.1"
    }
  }
}



provider "azapi" {
  subscription_id = var.subscription_id

}

# provider "azurerm" {
#   subscription_id   = var.subscription_id
#   tenant_id         = var.tenant_id
#   client_id         = var.client_id
#   client_secret     = var.client_secret

#   features {}
# }

 provider "databricks" {
   host = local.databricks_workspace_host
   token="${chomp(data.local_file.accesstokenfile.content)}"
 }
