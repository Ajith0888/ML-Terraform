resource "azurerm_network_interface" "mlnic" {
  name                = var.nicname
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "mlnicconfig"
    subnet_id                     = azurerm_subnet.mlsubnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mlpublicip.id
  }

  depends_on = [
    azurerm_public_ip.mlpublicip,
    azurerm_network_security_group.mlnsg,
    azurerm_subnet.mlsubnets

  ]


}

resource "azurerm_network_interface" "mlnic2" {
  name                = var.nicname2
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "mlnicconfig2"
    subnet_id                     = azurerm_subnet.mlsubnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mlpublicip2.id
  }

  depends_on = [
    azurerm_public_ip.mlpublicip2,
    azurerm_network_security_group.mlnsg,
    azurerm_subnet.mlsubnets

  ]


}

resource "azurerm_network_interface" "mlnic3" {
  name                = var.nicname3
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "mlnicconfig3"
    subnet_id                     = azurerm_subnet.mlsubnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mlpublicip3.id
  }

  depends_on = [
    azurerm_public_ip.mlpublicip3,
    azurerm_network_security_group.mlnsg,
    azurerm_subnet.mlsubnets

  ]


}

resource "azurerm_network_interface_security_group_association" "mlnic" {
  network_interface_id      = azurerm_network_interface.mlnic.id
  network_security_group_id = azurerm_network_security_group.mlnsg.id

  depends_on = [
    azurerm_network_interface.mlnic
  ]


}


resource "azurerm_network_interface_security_group_association" "mlnic2" {
  network_interface_id      = azurerm_network_interface.mlnic2.id
  network_security_group_id = azurerm_network_security_group.mlnsg.id

  depends_on = [
    azurerm_network_interface.mlnic2
  ]


}


resource "azurerm_network_interface_security_group_association" "mlnic3" {
  network_interface_id      = azurerm_network_interface.mlnic3.id
  network_security_group_id = azurerm_network_security_group.mlnsg.id

  depends_on = [
    azurerm_network_interface.mlnic3
  ]


}