output "mlconsole" {
  value       = azurerm_linux_virtual_machine.mlvm.public_ip_address
  sensitive   = true
  description = "MarkLogic Admin Console IP"
  depends_on = [
    azurerm_linux_virtual_machine.mlvm
  ]
}
