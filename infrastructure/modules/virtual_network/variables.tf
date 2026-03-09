variable "app_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public_nsg" {
  type = string
}

variable "private_nsg" {
  type = string
}

variable "public_nat_ip" {
  type = string
}

variable "nat_gw_name" {
  type = string
}
