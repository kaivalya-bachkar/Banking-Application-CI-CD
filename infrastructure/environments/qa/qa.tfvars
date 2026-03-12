mod_app_name = "Banking_Application_Qa"

mod_vnet_name = "Banking_app_vnet_qa"

mod_vnet_cidr = "10.1.0.0/20"

mod_public_subnet_cidrs = [
  "10.1.0.0/22",
  "10.1.4.0/22"
]

mod_private_subnet_cidrs = [
  "10.1.8.0/23",
  "10.1.10.0/23",
  "10.1.12.0/24",
  "10.1.13.0/24"
]

mod_public_nsg = "Banking_app_public_nsg_qa"

mod_private_nsg = "Banking_app_private_nsg_qa"

mod_public_nat_ip = "Banking_app_nat_ip_qa"

mod_nat_gw_name = "Banking_app_nat_gw_qa"

#acr----------------------------------
mod_acr_name = "bankingAppRegistryQa"

mod_acr-vnet-link = "banking-acr-vnet-link-qa"

mod_acr-pe = "banking-acr-pe-qa"

mod_psc_name = "banking-acr-psc-qa"

mod_acr_dzg_name = "banking-acr-dns-zone-group-qa"
#aks--------------------------------------

mod_aks_name = "banking-app-aks-qa"

mod_dns_name = "bankingappaksqa"

mod_node_pool_name = "systempool"

mod_aks_node_count = 1

mod_aks_vm_size = "Standard_D2s_v3"

mod_comman_tag = "qa"

#db--------------------------------------------

mod_db_dns_zone_name = "banking.qa.postgres.database.azure.com"

mod_db_vnet_link = "bankingQaVnetZone.com"

mod_postgres_db_name = "bankingqa-psqlflexibleserver"

mod_db_sku_name = "B_Standard_B1ms"

mod_db_admin_user = "postgres"

mod_db_admin_password = "postgres"

