variable "mod_app_name" {
  type = string
}

variable "mod_vnet_name" {
  type = string
}

variable "mod_vnet_cidr" {
  type = string
}

variable "mod_public_subnet_cidrs" {
  type = list(string)
}
variable "mod_private_subnet_cidrs" {
  type = list(string)
}

variable "mod_public_nsg" {
  type = string
}

variable "mod_private_nsg" {
  type = string
}

variable "mod_public_nat_ip" {
  type = string
}

variable "mod_nat_gw_name" {
  type = string
}

#acr---------------------------------------

variable "mod_acr_name" {
  type = string
}

variable "mod_acr-vnet-link" {
  type = string
}

variable "mod_acr-pe" {
  type = string
}

variable "mod_psc_name" {
  type = string
}

variable "mod_acr_dzg_name" {
  type = string
}

#aks-------------------------------------

variable "mod_aks_name" {
  type = string
}

variable "mod_dns_name" {
  type = string
}

variable "mod_node_pool_name" {
  type = string
}

variable "mod_aks_node_count" {
  type = string
}

variable "mod_aks_vm_size" {
  type = string
}

variable "mod_comman_tag" {
  type = string
}

#db--------------------------------------------
variable "mod_db_dns_zone_name" {
  type = string
}

variable "mod_db_vnet_link" {
  type = string
}

variable "mod_postgres_db_name" {
  type = string
}

variable "mod_db_sku_name" {
  type = string
}

variable "mod_db_admin_user" {
  type = string
}

variable "mod_db_admin_password" {
  type = string
}

