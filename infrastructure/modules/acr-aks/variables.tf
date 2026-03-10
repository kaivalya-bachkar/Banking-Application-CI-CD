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

#aks-------------------------
variable "aks_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "aks_node_count" {
  type = string
}

variable "aks_vm_size" {
  type = string
}

variable "private_subnet_one_id" {
  type = string
}

variable "public_subnet_one_id" {
  type = string
}

variable "comman_tag" {
  type = string
}
