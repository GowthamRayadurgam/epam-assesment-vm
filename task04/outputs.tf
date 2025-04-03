output "pip_id" {
  value       = azurerm_public_ip.pip.id
  description = "pip id"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "subnetid"
}

output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "ipaddress"
}

output "vm_public_ipvm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "fqdn"
}

