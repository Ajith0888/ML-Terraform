  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the New Azure VM.
  {
  provisioner "file" {
    source      = "init-marklogic.sh"
    destination = "/tmp/init-marklogic.sh"
  }
  # Change permissions on bash script and execute on VM.
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init-marklogic.sh",
      "sudo sh /tmp/init-marklogic.sh",
    ]
  }
  
  # Login to the VM with the aws key.
  connection {
    type        = "ssh"
    user        = "${var.vmusername}"
    password    = ""
    private_key = file("~/.ssh/id_rsa.pub")
    host        = mlvm.mlpublicip.id
  }

  depends_on = [
      azurerm_linux_virtual_machine.mlvm
    ]
  }