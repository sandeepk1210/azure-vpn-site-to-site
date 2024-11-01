# Output for Virtual Network
output "onprem_vnet_id" {
  description = "The ID of the OnPrem Virtual Network."
  value       = azurerm_virtual_network.onprem_vnet.id
}

output "onprem_vnet_name" {
  description = "The name of the OnPrem Virtual Network."
  value       = azurerm_virtual_network.onprem_vnet.name
}

# Output for Default Subnet
output "onprem_default_subnet_id" {
  description = "The ID of the OnPrem Default Subnet."
  value       = azurerm_subnet.onprem_default_subnet.id
}

output "onprem_default_subnet_name" {
  description = "The name of the OnPrem Default Subnet."
  value       = azurerm_subnet.onprem_default_subnet.name
}

# Output for Key Vault Secret (Admin Password)
output "onprem_key_vault_secret_id" {
  description = "The ID of the Key Vault Secret for the OnPrem admin password."
  value       = azurerm_key_vault_secret.onprem_admin_password.id
}

# Outputs for Windows Virtual Machines
output "onprem_vm_ids" {
  description = "The IDs of the OnPrem Windows Virtual Machines."
  value       = azurerm_windows_virtual_machine.onprem_vm[*].id
}

output "onprem_vm_names" {
  description = "The names of the OnPrem Windows Virtual Machines."
  value       = azurerm_windows_virtual_machine.onprem_vm[*].name
}

output "onprem_vm_public_ips" {
  description = "The public IP addresses assigned to the OnPrem VMs."
  value       = azurerm_public_ip.onprem_public_ip[*].ip_address
}
