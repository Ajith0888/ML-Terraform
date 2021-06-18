resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
  address_space       = [ var.vnet_range ]

}

resource "azurerm_subnet" "mysubnets" {
    count = length(var.mysubnets)

    name = var.mysubnets[count.index]
    resource_group_name = "${var.rgname}"
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = [ cidrsubnet(var.vnetrange,8,count.index) ]

    depends_on = [
      azurerm_virtual_network.myvnet
    ]

  
}