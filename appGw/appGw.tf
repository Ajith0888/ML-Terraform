
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "my-rg-application-gateway-12345"
  location = "westeurope"
}

# Create a application gateway in the web_servers resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet-12345"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.254.0.0/16"]
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_subnet" "sub1" {
  name                 = "my-subnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "sub2" {
  name                 = "my-subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.254.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "my-pip-12345"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "mlpublicip1" {
  name                = "mlpublicip1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}


resource "azurerm_public_ip" "mlpublicip2" {
  name                = "mlpublicip2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_public_ip" "mlpublicip3" {
  name                = "mlpublicip3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}


# Create an application gateway
resource "azurerm_application_gateway" "network" {
  name                = "my-application-gateway-12345"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westeurope"

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "${azurerm_virtual_network.vnet.id}/subnets/${azurerm_subnet.sub1.name}"
  }

  frontend_port {
    name = "${azurerm_virtual_network.vnet.name}-feport"
    port = 80
  }

  frontend_port {
    name = "port_8000"
    port = 8000
  }

  frontend_port {
    name = "port_8001"
    port = 8001
  }


  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.vnet.name}-feip"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = "${azurerm_virtual_network.vnet.name}-beap"
    #    ip_addresses = [local.backend_ip_1, local.backend_ip_2, local.backend_ip_3]
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8000"
    cookie_based_affinity = "Enabled"
    port                  = 8000
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8001"
    cookie_based_affinity = "Enabled"
    port                  = 8001
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8002"
    cookie_based_affinity = "Enabled"
    port                  = 8002
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8003"
    cookie_based_affinity = "Enabled"
    port                  = 8003
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8004"
    cookie_based_affinity = "Enabled"
    port                  = 8004
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8005"
    cookie_based_affinity = "Enabled"
    port                  = 8005
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8006"
    cookie_based_affinity = "Enabled"
    port                  = 8006
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8007"
    cookie_based_affinity = "Enabled"
    port                  = 8007
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet.name}-be-htst-8008"
    cookie_based_affinity = "Enabled"
    port                  = 8008
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  http_listener {
    name                           = "${azurerm_virtual_network.vnet.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8000"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
    frontend_port_name             = "port_8000"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8001"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
    frontend_port_name             = "port_8001"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.vnet.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.vnet.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.vnet.name}-be-htst"
  }


  request_routing_rule {
    name                       = "rule-8000"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8000"
    backend_address_pool_name  = "${azurerm_virtual_network.vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.vnet.name}-be-htst-8000"
  }


  request_routing_rule {
    name                       = "rule-8001"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8001"
    backend_address_pool_name  = "${azurerm_virtual_network.vnet.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.vnet.name}-be-htst-8001"
  }


  probe {
    interval            = 30
    name                = "health"
    host                = "test.marklogic.com"
    path                = "/"
    protocol            = "http"
    timeout             = 30
    unhealthy_threshold = 3
    match {
      status_code = ["200-401"]
    }
  }
}

locals {
  backend_ip_1 = "10.6.0.4"
  backend_ip_2 = "10.6.0.5"
  backend_ip_3 = "10.6.0.6"
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appGwbeap" {
  backend_address_pool_id = "${azurerm_virtual_network.vnet.name}-beap"
  ip_configuration_name   = "nicappGwbeap"
  network_interface_id    = ""
}