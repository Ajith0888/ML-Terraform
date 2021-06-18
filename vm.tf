resource "azurerm_storage_account" "mlstorageaccount" {
    name                = "${var.storaccountname}"
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"
    account_replication_type  = "LRS"
    account_tier              = "Standard"
  
}


resource "azurerm_linux_virtual_machine" "mlvm" {
    name                = var.vmname
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"
    size = "${var.vmsku}"
    admin_username = "mladmin"
    admin_password = "Ml@dmin321"
    network_interface_ids = [ azurerm_network_interface.mlnic.id ]
    disable_password_authentication = false

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "{var.os_disktype}"
  }

  source_image_reference {
    publisher = "marklogic"
    offer     = "marklogic-developer-10"
    sku       = "ml10064_centos8"
    version   = "1.0.0"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mlstorageaccount.primary_blob_endpoint
  }

 depends_on = [
   azurerm_storage_account.mlstorageaccount,
   azurerm_network_interface.mlnic

 ]
  
}