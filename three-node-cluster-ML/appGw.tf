# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.vnet_name}-beap"
  frontend_port_name             = "${var.vnet_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_name}-feip"
  http_setting_name              = "${var.vnet_name}-be-htst"
  listener_name                  = "${var.vnet_name}-httplstn"
  request_routing_rule_name      = "${var.vnet_name}-rqrt"
}

# Create an application gateway
resource "azurerm_application_gateway" "network" {
  name                = var.appgwname
  location            = var.location
  resource_group_name = var.rgname

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.mlsubnets[1].id
  }

  frontend_port {
    name = "${var.vnet_name}-feport"
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
  frontend_port {
    name = "port_8002"
    port = 8002
  }
  frontend_port {
    name = "port_8003"
    port = 8003
  }
  frontend_port {
    name = "port_8004"
    port = 8004
  }
  frontend_port {
    name = "port_8005"
    port = 8005
  }
  frontend_port {
    name = "port_8006"
    port = 8006
  }
  frontend_port {
    name = "port_8007"
    port = 8007
  }
  frontend_port {
    name = "port_8008"
    port = 8008
  }

  frontend_ip_configuration {
    name                 = "${var.vnet_name}-feip"
    public_ip_address_id = azurerm_public_ip.mlappgwpip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    #    ip_addresses = [local.backend_ip_1, local.backend_ip_2, local.backend_ip_3]
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8000"
    cookie_based_affinity = "Enabled"
    port                  = 8000
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8001"
    cookie_based_affinity = "Enabled"
    port                  = 8001
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8002"
    cookie_based_affinity = "Enabled"
    port                  = 8002
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8003"
    cookie_based_affinity = "Enabled"
    port                  = 8003
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8004"
    cookie_based_affinity = "Enabled"
    port                  = 8004
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8005"
    cookie_based_affinity = "Enabled"
    port                  = 8005
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8006"
    cookie_based_affinity = "Enabled"
    port                  = 8006
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8007"
    cookie_based_affinity = "Enabled"
    port                  = 8007
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst-8008"
    cookie_based_affinity = "Enabled"
    port                  = 8008
    protocol              = "Http"
    request_timeout       = 30
    probe_name            = "health"
  }

  http_listener {
    name                           = "${var.vnet_name}-httplstn"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "${var.vnet_name}-feport"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8000"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8000"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8001"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8001"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8002"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8002"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8003"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8003"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8004"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8004"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8005"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8005"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8006"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8006"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8007"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8007"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-8008"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "port_8008"
    protocol                       = "Http"
  }

  #  request_routing_rule {
  #    name                       = "${var.vnet_name}-rqrt"
  #    rule_type                  = "Basic"
  #    http_listener_name         = "${var.vnet_name}-httplstn"
  #    backend_address_pool_name  = local.backend_address_pool_name
  #    backend_http_settings_name = "${var.vnet_name}-be-htst"
  #  }


  request_routing_rule {
    name                       = "rule-8000"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8000"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8000"
  }


  request_routing_rule {
    name                       = "rule-8001"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8001"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8001"
  }


  request_routing_rule {
    name                       = "rule-8002"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8002"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8002"
  }
  request_routing_rule {
    name                       = "rule-8003"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8003"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8003"
  }
  request_routing_rule {
    name                       = "rule-8004"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8004"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8004"
  }
  request_routing_rule {
    name                       = "rule-8005"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8005"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8005"
  }
  request_routing_rule {
    name                       = "rule-8006"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8006"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8006"
  }
  request_routing_rule {
    name                       = "rule-8007"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8007"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8007"
  }

  request_routing_rule {
    name                       = "rule-8008"
    rule_type                  = "Basic"
    http_listener_name         = "listener-8008"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${var.vnet_name}-be-htst-8008"
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
  backend_ip_1 = azurerm_network_interface.mlnic.id
  backend_ip_2 = azurerm_network_interface.mlnic2.id
  backend_ip_3 = azurerm_network_interface.mlnic3.id
}


resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appGwbeap" {
  backend_address_pool_id = azurerm_application_gateway.network.backend_address_pool.0.id
  ip_configuration_name   = "mlnicconfig"
  network_interface_id    = azurerm_network_interface.mlnic.id
  depends_on              = [azurerm_application_gateway.network]
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appGwbeap2" {
  backend_address_pool_id = azurerm_application_gateway.network.backend_address_pool.0.id
  ip_configuration_name   = "mlnicconfig2"
  network_interface_id    = azurerm_network_interface.mlnic2.id
  depends_on              = [azurerm_application_gateway.network]
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appGwbeap3" {
  backend_address_pool_id = azurerm_application_gateway.network.backend_address_pool.0.id
  ip_configuration_name   = "mlnicconfig3"
  network_interface_id    = azurerm_network_interface.mlnic3.id
  depends_on              = [azurerm_application_gateway.network]
}

