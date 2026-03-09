module "vn" {
  source               = "./modules/vn"
  App_name             = var.mod_App_name
  vnet_name            = var.mod_vnet_name
  vnet_cidr            = var.mod_vnet_cidr
  public_subnet_cidrs  = var.mod_public_subnet_cidrs
  private_subnet_cidrs = var.mod_private_subnet_cidrs
  public_nsg           = var.mod_public_nsg
  private_nsg          = var.mod_private_nsg
  public_nat_ip        = var.mod_public_nat_ip
  nat_gw_name          = var.mod_nat_gw_name
}
