# Random password
resource "random_password" "onprem_admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# Store Admin Password in Key Vault
resource "azurerm_key_vault_secret" "onprem_admin_password" {
  name         = "onprem-vm-admin-password"
  value        = random_password.onprem_admin_password.result
  key_vault_id = azurerm_key_vault.kv.id
}

# Windows Virtual Machines
resource "azurerm_windows_virtual_machine" "onprem_vm" {
  name                = var.onprem_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = azurerm_key_vault_secret.onprem_admin_password.value
  network_interface_ids = [
    azurerm_network_interface.onprem_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Add Custom Script Extension to install Remote Access feature
resource "azurerm_virtual_machine_extension" "install_remote_access" {
  name                 = "installRemoteAccess"
  virtual_machine_id   = azurerm_windows_virtual_machine.onprem_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = "powershell Add-WindowsFeature RemoteAccess,DirectAccess-VPN,Routing"
  })
}

# Public IPs for VMs
resource "azurerm_public_ip" "onprem_public_ip" {
  name                = "onprem-vm-public-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# Network Interface
resource "azurerm_network_interface" "onprem_nic" {
  name                = "onprem-vm-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.onprem_default_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.onprem_public_ip.id
  }
}

# Network Security Group
resource "azurerm_network_security_group" "onprem_nsg" {
  name                = "onprem-vm-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-rdp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with each NIC
resource "azurerm_network_interface_security_group_association" "onprem_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.onprem_nic.id
  network_security_group_id = azurerm_network_security_group.onprem_nsg.id
}
