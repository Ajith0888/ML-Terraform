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
  virtual_machine_id = azurerm_virtual_machine.mlvm.id
  lun                = "0"
  caching            = "ReadOnly"
}