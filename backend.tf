terraform {
  backend "azurerm" {
    resource_group_name   = "$new_rg"  #Advisable to use separate RG for Terraform Backend. 
    storage_account_name  = "$new_st_acct" 
    container_name        = "tstate"
    key                   = "terraform.tfstate"
  }
}
