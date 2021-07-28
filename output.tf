output "MLconsolePublicIP" {
  value       = azurerm_linux_virtual_machine.mlvm.public_ip_address
  sensitive   = false
  description = "MarkLogic Admin Primary Console IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm
  ]
}

output "MLconsolePublicIP2" {
  value       = azurerm_linux_virtual_machine.mlvm2.public_ip_address
  sensitive   = false
  description = "MarkLogic Admin Secondary Console IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm2
  ]
}
