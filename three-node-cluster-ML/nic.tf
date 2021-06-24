resource "azurerm_network_interface" "mlnic" {
    count               = 3
    name                = "${var.nicname}${count.index}"
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"

    ip_configuration {
      name = "${var.nicname}${count.index}"
      subnet_id = azurerm_subnet.mlsubnets[0].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.mlpublicip.id
    }

    depends_on = [
        azurerm_public_ip.mlpublicip,
        azurerm_network_security_group.mlnsg,
        azurerm_subnet.mlsubnets
      
    ]

  
}

resource "azurerm_network_interface_security_group_association" "mlnic" {
    network_interface_id = azurerm_network_interface.mlnic.id
    network_security_group_id = azurerm_network_security_group.mlnsg.id

    depends_on = [
      azurerm_network_interface.mlnic
    ]

  
}