output "resource-group-name" {
  value = azurerm_resource_group.rg.name
}

output "resource-group-location" {
  value = azurerm_resource_group.rg.location
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "public_subnet_one_id" {
  value = azurerm_subnet.public[0].id
}

output "private_subnet_one_id" {
  value = azurerm_subnet.private[0].id
}

output "private_subnet_two_id" {
  value = azurerm_subnet.private[1].id
}

output "private_subnet_three_id" {
  value = azurerm_subnet.private[2].id
}
