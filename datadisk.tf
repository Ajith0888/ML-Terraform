  resource "azurerm_managed_disk" "mldisk" {
  name                 = "${var.vmname}-disk1"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
  storage_account_type = "${var.st_accttype}"
  create_option        = "Empty"
  disk_size_gb         = "${var.datadisksize}"

  depends_on = [
      azurerm_resource_group.mlrg
  ]  
}

resource "azurerm_virtual_machine_data_disk_attachment" "mldisk" {
  managed_disk_id    = azurerm_managed_disk.mldisk.id
  virtual_machine_id = azurerm_linux_virtual_machine.mlvm.id
  lun                = "0"
  caching            = "ReadOnly"

  depends_on = [
   azurerm_linux_virtual_machine.mlvm
   ]


}


