provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rsg" {
  name = "rp-all"
}

resource "azurerm_kubernetes_cluster" "rp-all" {
  name                = "RP-k8s"
  location            = "Sweden Central"
  resource_group_name = data.azurerm_resource_group.rsg.name
  dns_prefix          = "RPdnsprefix"
  kubernetes_version  = "1.25.6"

  default_node_pool {
    name       = "agentpool"
    node_count = 2
    vm_size    = "Standard_B2s"
    zones      = ["1"]
  }
  identity {
    type = "SystemAssigned"
  }
}
