variable "mod_App_name" {
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
