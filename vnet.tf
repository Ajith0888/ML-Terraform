resource "azurerm_virtual_network" "mlvnet" {
  name                = var.vnet_name
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
  address_space       = [ var.vnet_range ]

  depends_on = [
      azurerm_resource_group.mlrg
    ]  

}

resource "azurerm_subnet" "mlsubnets" {
    count = length(var.mlsubnets)

    name = var.mlsubnets[count.index]
    resource_group_name = "${var.rgname}"
    virtual_network_name = azurerm_virtual_network.mlvnet.name
    address_prefixes = [ cidrsubnet(var.vnetrange,8,count.index) ]

    depends_on = [
      azurerm_virtual_network.mlvnet
    ]
  
}