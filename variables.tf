variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

# Network
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "default_subnet_name" {
  type        = string
  description = "Name of the default subnet"
}

variable "gateway_subnet_name" {
  type        = string
  description = "Name of the gateway subnet"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "default_subnet_cidr" {
  type        = string
  description = "CIDR block for the default subnet"
}

variable "gateway_subnet_cidr" {
  type        = string
  description = "CIDR block for the gateway subnet"
}

# VM
variable "vm_name" {
  type        = string
  description = "Name of the virtual machines"
}

variable "vm_count" {
  type        = number
  description = "The number of virtual machines to create"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machines"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machines"
}

# Virtual Network Gateway
variable "vpn_gateway_name" {
  type        = string
  description = "Name of the VPN gateway"
}

variable "gateway_sku" {
  type        = string
  description = "Gateway SKU"
}

variable "p2s_address_pool" {
  type        = list(string)
  description = "Point-to-site configuration address pool that will be assigned to the client machines connectinv to this VPN."
}

variable "s2s_connection_name" {
  type        = string
  description = "S2S connection name"
}
