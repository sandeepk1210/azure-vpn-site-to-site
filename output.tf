# Output for Virtual Network
output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

# Output for Default Subnet
output "default_subnet_id" {
  description = "The ID of the Default Subnet."
  value       = azurerm_subnet.default_subnet.id
}

output "default_subnet_name" {
  description = "The name of the Default Subnet."
  value       = azurerm_subnet.default_subnet.name
}

# Output for Gateway Subnet
output "gateway_subnet_id" {
  description = "The ID of the Gateway Subnet."
  value       = azurerm_subnet.gateway_subnet.id
}

output "gateway_subnet_name" {
  description = "The name of the Gateway Subnet."
  value       = azurerm_subnet.gateway_subnet.name
}

# Output for Public IP
output "vpn_gateway_ip" {
  description = "The public IP address of the Virtual Network Gateway."
  value       = azurerm_public_ip.vpn_gateway_ip.ip_address
}

# Output for Virtual Network Gateway
output "vpn_gateway_id" {
  description = "The ID of the Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.vpn_gateway.id
}

output "vpn_gateway_name" {
  description = "The name of the Virtual Network Gateway."
  value       = azurerm_virtual_network_gateway.vpn_gateway.name
}


# Output for Random String (Unique Key Vault Name)
output "key_vault_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.kv.name
}

# Output for Key Vault ID
output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

# Output for Key Vault Secret (Admin Password)
output "key_vault_secret_id" {
  description = "The ID of the Key Vault Secret for the admin password."
  value       = azurerm_key_vault_secret.admin_password.id
}

# Outputs for Windows Virtual Machines
output "vm_ids" {
  description = "The IDs of the Windows Virtual Machines."
  value       = azurerm_windows_virtual_machine.vm[*].id
}

output "vm_names" {
  description = "The names of the Windows Virtual Machines."
  value       = azurerm_windows_virtual_machine.vm[*].name
}

# output "vm_public_ips" {
#   description = "The public IP addresses assigned to the VMs."
#   value       = azurerm_public_ip.public_ip[*].ip_address
# }
