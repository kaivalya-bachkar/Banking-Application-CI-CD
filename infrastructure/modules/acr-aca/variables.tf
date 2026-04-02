variable "acr_name" {
  type = string
}

variable "resource-group-name" {
  type = string
}

variable "resource-group-location" {
  type = string
}

variable "acr-vnet-link" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "acr-pe" {
  type = string
}

variable "private_subnet_two_id" {
  type = string
}

variable "psc_name" {
  type = string
}

variable "acr_dzg_name" {
  type = string
}

# acas-------------------------
variable "private_subnet_one_id" {
  type = string
}

variable "aca_environments" {
  type = set(string)
}
