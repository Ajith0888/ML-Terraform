resource "azurerm_network_interface" "mlnic" {
    name = var.nicname
    location            = azurerm_resource_group.rg-ajith-oneamerica.location
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name

    ip_configuration {
      name = "mlnicconfig"
      subnet_id = azurerm_subnet.subnets[0].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.mlpublicip.id
    }

    depends_on = [
        azurerm_public_ip.mlpublicip,
        azurerm_network_security_group.mlnsg,
        azurerm_subnet.mysubnets
      
    ]

  
}

resource "azurerm_network_interface_security_group_association" "web" {
    network_interface_id = azurerm_network_interface.vmnic.id
    network_security_group_id = azurerm_network_security_group.webnsg.id
  
}