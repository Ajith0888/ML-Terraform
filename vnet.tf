resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg-ajith-oneamerica.location
  resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "${var.vnet_name}"
  }
}

