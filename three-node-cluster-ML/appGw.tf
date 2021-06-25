resource "azurerm_application_gateway" "appgw" {
  location = var.location
  name = var.appgw
  resource_group_name = var.rgname
  backend_address_pool {
    name = "${var.appgw}-appGatewayBackendPool"
  }
  backend_http_settings {
    cookie_based_affinity = ""
    name = ""
    port = 0
    protocol = ""
  }
  frontend_ip_configuration {
    name = "${var.appgw}-feappGwIp"
    public_ip_address_id = azurerm_public_ip.appGatewayIp.id
  }
  frontend_port {
    name = "${var.appgw}-feappGwPort"
    port = 0
  }
  gateway_ip_configuration {
    name = "${var.appgw}-appGatewayIpConfig"
    subnet_id = azurerm_subnet.mlsubnets[0].id
  }
  http_listener {
    frontend_ip_configuration_name = ""
    frontend_port_name = ""
    name = ""
    protocol = ""
  }
  request_routing_rule {
    http_listener_name = ""
    name = ""
    rule_type = ""
  }
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    capacity = 2
  }

  probe {
    interval = 30
    name = "health"
    host = "test.marklogic.com"
    path = "/"
    protocol = "http"
    timeout = 30
    unhealthy_threshold = 3
    match {
      status_code = ["200-401"]
    }
  }
}