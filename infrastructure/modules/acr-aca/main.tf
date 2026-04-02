resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource-group-name
  location                      = var.resource-group-location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  network_rule_set {
    default_action = "Deny"
  }
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

#azure container app------------------------------------------
resource "azurerm_log_analytics_workspace" "aca_logs" {
  name                = "law-banking-shared"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "aca_env" {
  for_each = var.aca_environments

  name                           = "banking-aca-env-${each.key}"
  location                       = var.resource-group-location
  resource_group_name            = var.resource-group-name
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.aca_logs.id
  infrastructure_subnet_id       = var.private_subnet_one_id
  internal_load_balancer_enabled = false
}

resource "azurerm_user_assigned_identity" "aca_identity" {
  name                = "aca-acr-pull-identity"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
}

resource "azurerm_role_assignment" "aca_acr_pull" {
  principal_id                     = azurerm_user_assigned_identity.aca_identity.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
