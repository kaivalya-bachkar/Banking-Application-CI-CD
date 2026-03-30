mod_app_name = "Banking_Application_Dev"

mod_vnet_name = "Banking_app_vnet_dev"

mod_vnet_cidr = "10.0.0.0/20"

mod_public_subnet_cidrs = [
  "10.0.0.0/22",
  "10.0.4.0/22"
]

mod_private_subnet_cidrs = [
  "10.0.8.0/23",
  "10.0.10.0/23",
  "10.0.12.0/24",
  "10.0.13.0/24"
]

mod_public_nsg = "Banking_app_public_nsg_dev"

mod_private_nsg = "Banking_app_private_nsg_dev"

mod_public_nat_ip = "Banking_app_nat_ip_dev"

mod_nat_gw_name = "Banking_app_nat_gw_dev"

#acr----------------------------------
mod_acr_name = "bankingAppRegistryDev"

mod_acr-vnet-link = "banking-acr-vnet-link-dev"

mod_acr-pe = "banking-acr-pe-dev"

mod_psc_name = "banking-acr-psc-dev"

mod_acr_dzg_name = "banking-acr-dns-zone-group-dev"
#aks--------------------------------------

mod_aks_name = "banking-app-aks-dev"

mod_dns_name = "bankingappaksdev"

mod_node_pool_name = "systempool"

mod_aks_min_count = 1

mod_aks_max_count = 2

mod_aks_vm_size = "Standard_D2s_v3"

mod_comman_tag = "dev"

#db--------------------------------------------

mod_db_dns_zone_name = "banking.dev.postgres.database.azure.com"

mod_db_vnet_link = "bankingDevVnetZone.com"

mod_postgres_db_name = "bankingdev-psqlflexibleserver"

mod_db_sku_name = "B_Standard_B1ms"

mod_db_admin_user = "postgres"

mod_db_admin_password = "postgres"

