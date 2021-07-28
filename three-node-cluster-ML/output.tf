output "MLnodePublicIP" {
  value       = azurerm_linux_virtual_machine.mlvm.public_ip_address
  sensitive   = false
  description = "MarkLogic Node1 Server Public IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm
  ]
}

output "MLnodePublicIP2" {
  value       = azurerm_linux_virtual_machine.mlvm2.public_ip_address
  sensitive   = false
  description = "MarkLogic Node2 Server Public IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm2
  ]
}

output "MLnodePublicIP3" {
  value       = azurerm_linux_virtual_machine.mlvm3.public_ip_address
  sensitive   = false
  description = "MarkLogic Node3 Server Public IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm3
  ]
}

output "MLappGwPublicIP" {
  value       = azurerm_public_ip.mlappgwpip.id
  sensitive   = true
  description = "Azure App Gw Public IP"
  depends_on = [
    azurerm_public_ip.mlappgwpip
  ]
}
