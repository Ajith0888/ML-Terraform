resource "azurerm_public_ip" "mlpublicip" {
    name = var.publicip_name
    location            = azurerm_resource_group.rg-ajith-oneamerica.location
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
    allocation_method = "Dynamic"

    depends_on = [
      azurerm_network_security_group.mlnsg
    ]
  
}