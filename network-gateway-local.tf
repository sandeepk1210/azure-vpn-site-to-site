# Define the Local Network Gateway
resource "azurerm_local_network_gateway" "local_gateway" {
  name                = "localNetworkGateway"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  # Replace this with your on-premises network IP address range
  gateway_address = azurerm_public_ip.onprem_public_ip.ip_address # Public IP of the on-premises VPN device

  # Address space of the on-premises network to connect to Azure
  address_space = var.onprem_address_space

  tags = {
    environment = "NONPROD"
  }
}
