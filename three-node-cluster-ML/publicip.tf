resource "azurerm_public_ip" "mlpublicip" {
    name                = "${var.publicip_name}"
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"
    allocation_method = "Dynamic"

    depends_on = [
      azurerm_network_security_group.mlnsg
    ]
  
}