resource_group_name = "Regroup_0hquVSe9fsZ_diqeXtC"

#Network
vnet_name           = "tooling-vnet"
default_subnet_name = "default-subnet"
gateway_subnet_name = "GatewaySubnet"
address_space       = ["10.0.0.0/16"]
default_subnet_cidr = "10.0.0.0/24"
gateway_subnet_cidr = "10.0.1.0/24"

#VM
vm_name        = "vm"
admin_username = "adminuser"
vm_size        = "Standard_B2s"
vm_count       = 1

# Virtual Network Gateway
vpn_gateway_name = "app-gateway"
gateway_sku      = "VpnGw2" # Options: Basic, VpnGw1, VpnGw2, etc.
p2s_address_pool = ["172.16.0.0/24"]
s2s_connection_name = "s2s-company-connection"

# On-prem Network
onprem_vnet_name           = "onprem-vnet"
onprem_default_subnet_name = "onprem-default-subnet"
onprem_address_space       = ["10.1.0.0/16"]
onprem_default_subnet_cidr = "10.1.0.0/24"

# On-prem VM
# Using same variable for admin_username, vm_size and vm_count
onprem_vm_name = "companyvm"
