resource "azurerm_network_security_group" "mlnsg" {
    name = mlnsg
    location            = azurerm_resource_group.rg-ajith-oneamerica.location
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name

    security_rule  {
      access = "Allow"
      description = "default-allow-ssh"
      destination_address_prefix = "*"
      destination_port_range = "22"
      direction = "Inbound"
      name = "SSH"
      priority = 1050
      protocol = "TCP"
      source_address_prefix = "*"
      source_port_range = "*"
    } 
    security_rule  {
      access = "Allow"
      description = "HealthCheck"
      destination_address_prefix = "*"
      destination_port_range = "7997"
      direction = "Inbound"
      name = "HealthCheck"
      priority = 1040
      protocol = "TCP"
      source_address_prefix = "*"
      source_port_range = "*"
    }
    security_rule  {
      access = "Allow"
      description = "QConsole"
      destination_address_prefix = "*"
      destination_port_range = "8000"
      direction = "Inbound"
      name = "QConsole"
      priority = 1030
      protocol = "TCP"
      source_address_prefix = "*"
      source_port_range = "*"
    } 
    security_rule  {
      access = "Allow"
      description = "Manage"
      destination_address_prefix = "*"
      destination_port_range = "8002"
      direction = "Inbound"
      name = "Manage"
      priority = 1020
      protocol = "TCP"
      source_address_prefix = "*"
      source_port_range = "*"
    } 
    security_rule  {
      access = "Allow"
      description = "Admin"
      destination_address_prefix = "*"
      destination_port_range = "8001"
      direction = "Inbound"
      name = "Admin"
      priority = 1010
      protocol = "TCP"
      source_address_prefix = "*"
      source_port_range = "*"
    } 
    depends_on = [
      azurerm_virtual_network.myvnet,
      azurerm_subnet.mysubnets
    ]

  
}
