# Azure Site-to-Site VPN (S2S)

- **Connection Type**: Network-based (connects entire networks).
- **Use Case**: Suitable for securely connecting an entire on-premises network to an Azure Virtual Network.
- **Scalability**: Can handle a larger volume of traffic; supports enterprise-scale, always-on connectivity.
- **Encryption**: Uses IPsec/IKE for secure connections.

To understand best where Site-to-Site VPN is used, let see comparison of Azure’s main connectivity options: Point-to-Site (P2S), Site-to-Site (S2S), Virtual WAN, and ExpressRoute.

# Azure Connectivity Options: P2S, S2S, Virtual WAN, and ExpressRoute

Azure offers various options for connecting on-premises and remote locations to Azure Virtual Networks. Here’s a comparison of the main connectivity solutions: Point-to-Site (P2S) VPN, Site-to-Site (S2S) VPN, Virtual WAN, and ExpressRoute.

---

### 1. **Azure Point-to-Site (P2S) VPN**

- **Purpose**: Allows individual clients (like laptops and mobile devices) to securely connect to Azure virtual networks from any location.
- **Connection Type**: Securely connects over the internet using SSTP, IKEv2, or OpenVPN protocols.
- **Best Suited For**: Remote access for individuals or small teams.
- **Throughput**: Lower throughput since it depends on the internet connection quality.
- **Pros**: Easy to set up for remote users, cost-effective for small teams.
- **Cons**: Not suitable for large teams due to limited scalability.

### 2. **Azure Site-to-Site (S2S) VPN**

- **Purpose**: Establishes a secure, permanent connection between on-premises networks and Azure virtual networks, often used for hybrid environments.
- **Connection Type**: IPsec/IKE VPN tunnel over the internet.
- **Best Suited For**: Hybrid workloads and continuous connections between Azure and corporate networks.
- **Throughput**: Higher than P2S but still limited by internet quality.
- **Pros**: Good for extending on-premises networks into the cloud.
- **Cons**: Dependent on internet reliability; not ideal for very large data transfers or latency-sensitive applications.

### 3. **Azure Virtual WAN**

- **Purpose**: A scalable solution for connecting branch offices and remote locations to Azure and interconnecting resources across Azure regions.
- **Connection Type**: Aggregates P2S, S2S, and ExpressRoute in a hub-spoke architecture, often using SD-WAN.
- **Best Suited For**: Enterprises needing multiple connections across locations with centralized management.
- **Throughput**: High; improves with SD-WAN and ExpressRoute integration.
- **Pros**: Simplifies complex networks, centralized management, suitable for large organizations.
- **Cons**: More complex to set up and potentially more costly than S2S or P2S alone.

### 4. **Azure ExpressRoute**

- **Purpose**: Provides a private, dedicated connection between on-premises environments and Azure data centers, bypassing the public internet.
- **Connection Type**: Private, physical connection established through a network provider.
- **Best Suited For**: Mission-critical applications, high-throughput requirements, low latency, and consistent network performance.
- **Throughput**: Very high and consistent, with options ranging from 50 Mbps to 100 Gbps.
- **Pros**: Best-in-class performance, low latency, highly secure, and reliable.
- **Cons**: Higher cost; requires setup with a network provider, not suitable for every organization’s budget.

---

## Summary Table

| Feature             | **P2S VPN**              | **S2S VPN**              | **Virtual WAN**                     | **ExpressRoute**                    |
| ------------------- | ------------------------ | ------------------------ | ----------------------------------- | ----------------------------------- |
| **Primary Use**     | Remote user connections  | Hybrid cloud networking  | Branch office and remote access     | High-throughput, private connection |
| **Connection Type** | SSTP, IKEv2, OpenVPN     | IPsec/IKE VPN            | VPN, SD-WAN, or ExpressRoute        | Private dedicated link              |
| **Best For**        | Individuals, small teams | Hybrid/cloud extension   | Large enterprise with complex needs | Mission-critical, low-latency apps  |
| **Reliability**     | Medium                   | Medium                   | High                                | Very High                           |
| **Latency**         | Moderate (over internet) | Moderate (over internet) | Low (with SD-WAN or ExpressRoute)   | Very low                            |
| **Cost**            | Low                      | Medium                   | Variable (depends on components)    | High                                |

Each of these solutions serves different scenarios and budgets, with ExpressRoute being ideal for critical workloads, Virtual WAN for larger distributed setups, and P2S/S2S VPN for smaller or hybrid networks.

# Setup Process Overview

1. Create a Virtual Network:

   - Set up an Azure Virtual Network (VNet) with an address space that corresponds to your on-premises network. This will host your Azure resources.
   - Created in network.tf

2. Set Up a Gateway Subnet

   - Add a GatewaySubnet within your VNet, which is reserved for the VPN gateway. This subnet is essential for enabling secure VPN connections.
   - Created in network.tf

3. Configure the Virtual Network Gateway

   - Deploy an Azure Virtual Network Gateway in the GatewaySubnet. Choose the VPN type (Route-based or Policy-based) and select an appropriate SKU based on your bandwidth and performance requirements.
   - To create site-to-site connection, go to Virtual Network Gateway > Settings > Connection
   - Created in network-gateway-virtual.tf

4. Obtain Public IP for the VPN Gateway

   - Azure will assign a public IP address to the VPN gateway during the creation process. This IP address will act as the connection endpoint in Azure.
   - Created in network-gateway-virtual.tf

5. Configure a Local Network Gateway

   - Define a Local Network Gateway resource to represent your on-premises network in Azure. Specify the public IP of your on-premises VPN device and its address space.
   - Created in network-gateway-local.tf

6. Establish a Connection Between Gateways

   - Create a Site-to-Site connection that links the Virtual Network Gateway and Local Network Gateway. This connection will utilize IPsec/IKE for secure communication.
   - Created in network-gateway-virtual.tf and resource azurerm_virtual_network_gateway_connection is defined for this.

7. Set Up the On-Premises VPN Device

   - Configure your on-premises VPN device (e.g., router or firewall) to establish the IPsec/IKE connection with Azure. Microsoft provides specific configuration guidelines for various supported devices.
   - Router can be software or hardware based that has a public IP address. This public IP address is used to connect to the Public IP address of GatewaySubnet.
   - This example has implemented Software router.
   - This is done by using Windows Server 2019 which has role that allow us to have VPN/Routing capability.  
   - On Windows, have added WindowsFeature RemoteAccess,DirectAccess-VPN,Routing for this. Also have to configure Routing and Remote Access on the Windows machine.
   - Created in on-prem-network.tf, on-prem-vm.tf

8. Validate the VPN Connection

   - Once configured, check the connection status in Azure; it should indicate Connected. Test the connectivity between on-premises and Azure resources to ensure the VPN is operational.

9. Monitor and Troubleshoot (Optional)

   - Utilize Azure Network Watcher and VPN diagnostics for monitoring performance and troubleshooting connectivity issues as needed.
