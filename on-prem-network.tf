# Virtual Network
resource "azurerm_virtual_network" "onprem_vnet" {
  name                = var.onprem_vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.onprem_address_space
}

# Default Subnet
resource "azurerm_subnet" "onprem_default_subnet" {
  name                 = var.onprem_default_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.onprem_vnet.name
  address_prefixes     = [var.onprem_default_subnet_cidr]
}
