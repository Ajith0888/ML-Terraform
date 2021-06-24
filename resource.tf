
resource "azurerm_resource_group" "mlrg" {
  name     = var.rgname
  location = var.location
}

