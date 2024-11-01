# Public IP for the Virtual Network Gateway
resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = "vpn-gateway-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  type                = "Vpn"        # Options: Vpn, ExpressRoute
  vpn_type            = "RouteBased" # Options: PolicyBased, RouteBased
  sku                 = var.gateway_sku
  active_active       = false

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vpn_gateway_ip.id
    subnet_id            = azurerm_subnet.gateway_subnet.id
  }

  # Point to site configuration
  vpn_client_configuration {
    # Address pool is what will be assigned to the client machines connectinv to this VPN.
    address_space = var.p2s_address_pool

    root_certificate {
      name             = "root-cert"
      public_cert_data = base64encode(tls_self_signed_cert.root_cert.cert_pem)
    }
    vpn_client_protocols = ["IkeV2", "OpenVPN"]
  }

  tags = {
    environment = "NONPROD"
  }
}

#  Site-to-Site VPN Connection: Establish a connection from the Azure Virtual Network Gateway to the Local Network Gateway.
resource "azurerm_virtual_network_gateway_connection" "s2s_connection" {
  name                       = var.s2s_connection_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway.id
  type                       = "IPsec" # Set the type of connection

  # Shared key for authentication (must match on both gateways)
  shared_key = "YourSharedKeyHere"

  enable_bgp = false
}


# Enabling P2S VPN
# Root Certificate: Uses the tls provider to generate a self-signed root certificate that clients will need for P2S authentication.
resource "tls_private_key" "root_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "root_cert" {
  private_key_pem = tls_private_key.root_key.private_key_pem
  subject {
    common_name = "AzureRootCert"
  }
  validity_period_hours = 8760
  is_ca_certificate     = true
  allowed_uses          = ["cert_signing", "key_encipherment", "server_auth", "client_auth"]
}
