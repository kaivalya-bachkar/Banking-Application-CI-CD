# provider "azurerm" {
#   features {}
# }

# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

# resource "azurerm_virtual_network" "example" {
#   name                = "example-vn"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   address_space       = ["10.0.0.0/16"]
# }

# resource "azurerm_subnet" "example" {
#   name                 = "example-sn"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.2.0/24"]
#   service_endpoints    = ["Microsoft.Storage"]
#   delegation {
#     name = "fs"
#     service_delegation {
#       name = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#       ]
#     }
#   }
# }

resource "azurerm_private_dns_zone" "db_dns" {
  name                = var.db_dns_zone_name
  resource_group_name = var.resource-group-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db_dns_link" {
  name                  = var.db_vnet_link
  private_dns_zone_name = azurerm_private_dns_zone.db_dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource-group-name
  depends_on            = [var.private_subnet_three_id]
}

resource "azurerm_postgresql_flexible_server" "postgres_db" {
  name                          = var.postgres_db_name
  resource_group_name           = var.resource-group-name
  location                      = var.resource-group-location
  version                       = "14"
  delegated_subnet_id           = var.private_subnet_three_id
  private_dns_zone_id           = azurerm_private_dns_zone.db_dns.id
  public_network_access_enabled = false
  administrator_login           = var.db_admin_user
  administrator_password        = var.db_admin_password
  zone                          = "1"

  storage_mb = 32768

  sku_name   = var.db_sku_name
  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_link]

}
