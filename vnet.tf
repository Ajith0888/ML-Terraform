resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg-ajith-oneamerica.location
  resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "${var.vnet_name}"
  }
}

resource "azurerm_subnet" "mysubnets" {
    count = length(var.mysubnets)

    name = var.mysubnets[count.index]
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
    virtual_network_name = azurerm_virtual_network.dev-vnet
    address_prefixes = [ cidrsubnet(var.vnetrange,8,count.index) ]

    depends_on = [
      azurerm_virtual_network.dev-vnet
    ]

  
}