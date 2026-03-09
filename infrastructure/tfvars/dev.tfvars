mod_App_name = "Banking_Application_Dev"

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
