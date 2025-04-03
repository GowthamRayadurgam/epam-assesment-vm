output "vm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "fqdn"
}

output "vm_public_ip" {
  value       = azurerm_linux_virtual_machine.linux_vm.public_ip_address
  description = "public ip of vm"
}