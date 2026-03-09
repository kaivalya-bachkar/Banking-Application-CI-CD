module "Network" {
  source               = "./modules/virtual_network"
  app_name             = var.mod_app_name
  vnet_name            = var.mod_vnet_name
  vnet_cidr            = var.mod_vnet_cidr
  public_subnet_cidrs  = var.mod_public_subnet_cidrs
  private_subnet_cidrs = var.mod_private_subnet_cidrs
  public_nsg           = var.mod_public_nsg
  private_nsg          = var.mod_private_nsg
  public_nat_ip        = var.mod_public_nat_ip
  nat_gw_name          = var.mod_nat_gw_name
}

module "acr-aks" {
  source                  = "./modules/acr-aks"
  acr_name                = var.mod_acr_name
  resource-group-name     = module.Network.resource-group-name
  resource-group-location = module.Network.resource-group-location
  acr-vnet-link           = var.mod_acr-vnet-link
  vnet_id                 = module.Network.vnet_id
  acr-pe                  = var.mod_acr-pe
  private_subnet_two_id   = module.Network.private_subnet_two_id
  psc_name                = var.mod_psc_name
  acr_dzg_name            = var.mod_acr_dzg_name
  # -------------------------
  aks_name              = var.mod_aks_name
  dns_name              = var.mod_dns_name
  node_pool_name        = var.mod_node_pool_name
  aks_node_count        = var.mod_aks_node_count
  aks_vm_size           = var.mod_aks_vm_size
  private_subnet_one_id = module.Network.private_subnet_one_id
  comman_tag            = var.mod_comman_tag
}

module "postgres_db" {
  source                  = "./modules/postgresql_db"
  resource-group-name     = module.Network.resource-group-name
  resource-group-location = module.Network.resource-group-location
  vnet_id                 = module.Network.vnet_id
  db_dns_zone_name        = var.mod_db_dns_zone_name
  db_vnet_link            = var.mod_db_vnet_link
  postgres_db_name        = var.mod_postgres_db_name
  private_subnet_three_id = module.Network.private_subnet_three_id
  db_sku_name             = var.mod_db_sku_name
  db_admin_user           = var.mod_db_admin_user
  db_admin_password       = var.mod_db_admin_password
}
