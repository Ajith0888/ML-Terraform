terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ajith-oneamerica"
    storage_account_name = "stajithterraform"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
  }
}
