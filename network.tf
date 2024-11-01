# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space
}

# Default Subnet
resource "azurerm_subnet" "default_subnet" {
  name                 = var.default_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.default_subnet_cidr]
}

# Gateway Subnet
resource "azurerm_subnet" "gateway_subnet" {
  name                 = var.gateway_subnet_name # Must be named "GatewaySubnet" for Azure to use it for VPN Gateways
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.gateway_subnet_cidr]
}
