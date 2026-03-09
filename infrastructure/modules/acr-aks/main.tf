# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource-group-name
  location                      = var.resource-group-location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
}

resource "azurerm_private_dns_zone" "acr_dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource-group-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_link" {
  name                  = var.acr-vnet-link
  resource_group_name   = var.resource-group-name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "acr_pe" {
  name                = var.acr-pe
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  subnet_id           = var.private_subnet_two_id

  private_service_connection {
    name                           = var.psc_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.acr_dzg_name
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_dns.id]
  }
}

#aks cluster------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.aks_name
  location                = var.resource-group-location
  resource_group_name     = var.resource-group-name
  dns_prefix              = var.dns_name
  private_cluster_enabled = true

  default_node_pool {
    name           = var.node_pool_name
    node_count     = var.aks_node_count
    vm_size        = var.aks_vm_size
    vnet_subnet_id = var.private_subnet_one_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "var.comman_tag"
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
