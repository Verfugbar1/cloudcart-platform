output "resource_group_name" {
  description = "CloudCart resource group name."
  value       = azurerm_resource_group.cloudcart.name
}

output "resource_group_location" {
  description = "CloudCart resource group location."
  value       = azurerm_resource_group.cloudcart.location
}
output "vm_public_ip" {
  description = "Public IP of the CloudCart VM."
  value       = azurerm_public_ip.vm.ip_address
}