resource "azurerm_storage_account" "mlstorageaccount" {
    name = var.storaccountname
    location            = azurerm_resource_group.rg-ajith-oneamerica.location
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
    account_replication_type = "LRS"
    account_tier = "Standard"
  
}


resource "azurerm_linux_virtual_machine" "mlvm" {
    name = var.vmname
    location            = azurerm_resource_group.rg-ajith-oneamerica.location
    resource_group_name = azurerm_resource_group.rg-ajith-oneamerica.name
    size = "Standard_DS1_v2"
    admin_username = "mladmin"
    admin_password = "Ml@dmin321"
    network_interface_ids = [ azurerm_network_interface.mlnic.id ]
    disable_password_authentication = false

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  resource "azurerm_managed_disk" "mldisk" {
  name                 = "${var.vmname}-disk1"
  location             = azurerm_resource_group.rg-ajith-oneamerica.location
  resource_group_name  = azurerm_resource_group.rg-ajith-oneamerica.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 32
}

resource "azurerm_virtual_machine_data_disk_attachment" "mldisk" {
  managed_disk_id    = azurerm_managed_disk.mldisk.id
  virtual_machine_id = azurerm_linux_virtual_machine.mlvm.id
  lun                = "0"
  caching            = "ReadOnly"
}

  source_image_reference {
    publisher = "marklogic"
    offer     = "marklogic-developer-10"
    sku       = "ml10064_centos8s"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mlstorageaccount.primary_blob_endpoint
  }

 depends_on = [
   azurerm_storage_account.mlstorageaccount,
   azurerm_network_interface.mlnic

 ]
  
}