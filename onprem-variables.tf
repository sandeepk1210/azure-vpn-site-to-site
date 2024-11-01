# OnPrem-Network
variable "onprem_vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "onprem_default_subnet_name" {
  type        = string
  description = "Name of the default subnet"
}

variable "onprem_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "onprem_default_subnet_cidr" {
  type        = string
  description = "CIDR block for the default subnet"
}

# VM
variable "onprem_vm_name" {
  type        = string
  description = "Name of the onprem virtual machines"
}
