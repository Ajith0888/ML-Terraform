resource "azurerm_storage_account" "mlstorageaccount" {
  name                     = var.storaccountname
  location                 = var.location
  resource_group_name      = var.rgname
  account_replication_type = var.st_repltype
  account_tier             = var.st_accttier

  depends_on = [
    azurerm_resource_group.mlrg
  ]
}

resource "azurerm_availability_set" "avset" {
  name                         = var.avset
  location                     = var.location
  resource_group_name          = var.rgname
  platform_fault_domain_count  = 3
  platform_update_domain_count = 20
  managed                      = true

  depends_on = [
    azurerm_resource_group.mlrg
  ]

}



resource "azurerm_linux_virtual_machine" "mlvm" {
  name                = var.vmname
  location            = var.location
  resource_group_name = var.rgname
  size                = var.vmsku
  admin_username      = var.vmusername
  availability_set_id = azurerm_availability_set.avset.id
  #admin_password = "${var.vmpasswd}"
  #Its better to use SSH Keys
  admin_ssh_key {
    username   = var.vmusername
    public_key = file("~/.ssh/id_rsa.pub")
  }
  network_interface_ids = [azurerm_network_interface.mlnic.id]
  #disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disktype
  }

  plan {
    name      = "ml10064_centos8"
    publisher = "marklogic"
    product   = "marklogic-developer-10"
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
  #local exec to update MarkLogic Input variables 
  #provisioner "local-exec" {
  #  command     = "echo -e \nexport USER=${var.mluname}\nexport PASS=${var.mlpass}\nexport BOOTSTRAP_HOST=${var.vmname} >> ../scripts/vars_env"
  #}

  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the New Azure VM.
  provisioner "file" {
    source      = "../scripts"
    destination = "/tmp"
  }
  # Change permissions on bash script and execute on VM.
  provisioner "remote-exec" {
    inline = [
      "chmod -Rv +x /tmp/scripts/",
      "sudo sh /tmp/scripts/config-bootstrap-node.sh ${var.mluname} ${var.mlpass} ${var.vmname}",
    ]
  }

  # Login to the VM with the aws key.
  connection {
    type        = "ssh"
    user        = var.vmusername
    password    = ""
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.mlvm.public_ip_address
  }


  depends_on = [
    azurerm_storage_account.mlstorageaccount,
    azurerm_network_interface.mlnic
  ]

  timeouts {
    create = "15m"
    delete = "30m"
  }

}

resource "azurerm_linux_virtual_machine" "mlvm2" {
  name                = var.vmname2
  location            = var.location
  resource_group_name = var.rgname
  size                = var.vmsku
  admin_username      = var.vmusername
  availability_set_id = azurerm_availability_set.avset.id
  #admin_password = "${var.vmpasswd}"
  #Its better to use SSH Keys
  admin_ssh_key {
    username   = var.vmusername
    public_key = file("~/.ssh/id_rsa.pub")
  }
  network_interface_ids = [azurerm_network_interface.mlnic2.id]
  #disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disktype
  }

  plan {
    name      = "ml10064_centos8"
    publisher = "marklogic"
    product   = "marklogic-developer-10"
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
  #local exec to update MarkLogic Input variables 
  #provisioner "local-exec" {
  #  command     = "echo -e \nexport JOINING_HOST=${var.vmname2} >> ../scripts/vars_env"
  #}


  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the New Azure VM.
  provisioner "file" {
    source      = "../scripts"
    destination = "/tmp"
  }
  # Change permissions on bash script and execute on VM.
  provisioner "remote-exec" {
    inline = [
      "chmod -Rv +x /tmp/scripts/",
      "sudo sh /tmp/scripts/config-additional-node.sh ${var.mluname} ${var.mlpass} ${var.vmname} ${var.vmname2}",
    ]
  }

  # Login to the VM with the aws key.
  connection {
    type        = "ssh"
    user        = var.vmusername
    password    = ""
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.mlvm2.public_ip_address
  }


  depends_on = [
    azurerm_storage_account.mlstorageaccount,
    azurerm_network_interface.mlnic2,
    azurerm_linux_virtual_machine.mlvm
  ]

  timeouts {
    create = "15m"
    delete = "30m"
  }

}

resource "azurerm_linux_virtual_machine" "mlvm3" {
  name                = var.vmname3
  location            = var.location
  resource_group_name = var.rgname
  size                = var.vmsku
  admin_username      = var.vmusername
  #admin_password = "${var.vmpasswd}"
  #Its better to use SSH Keys
  admin_ssh_key {
    username   = var.vmusername
    public_key = file("~/.ssh/id_rsa.pub")
  }
  network_interface_ids = [azurerm_network_interface.mlnic3.id]
  #disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disktype
  }

  plan {
    name      = "ml10064_centos8"
    publisher = "marklogic"
    product   = "marklogic-developer-10"
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

  #local exec to update MarkLogic Input variables 
  #provisioner "local-exec" {
  #  command     = "echo -e \nexport JOINING_HOST=${var.vmname3} >> ../scripts/vars_env"
  #}

  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the New Azure VM.
  provisioner "file" {
    source      = "../scripts"
    destination = "/tmp"
  }
  # Change permissions on bash script and execute on VM.
  provisioner "remote-exec" {
    inline = [
      "chmod -Rv +x /tmp/scripts/",
      "sudo sh /tmp/scripts/config-additional-node.sh ${var.mluname} ${var.mlpass} ${var.vmname} ${var.vmname3}",
    ]
  }

  # Login to the VM with the aws key.
  connection {
    type        = "ssh"
    user        = var.vmusername
    password    = ""
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.mlvm3.public_ip_address
  }


  depends_on = [
    azurerm_storage_account.mlstorageaccount,
    azurerm_network_interface.mlnic3,
    azurerm_linux_virtual_machine.mlvm
  ]

  timeouts {
    create = "15m"
    delete = "30m"
  }

}