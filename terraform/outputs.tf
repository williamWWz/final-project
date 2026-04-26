// Output useful values after apply

output "container_fqdn" {
  description = "Fully qualified domain name for the running container"
  value       = azurerm_container_group.aci.fqdn
}

output "registry_login_server" {
  description = "URL of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "registry_admin_username" {
  description = "Admin username for the ACR"
  value       = azurerm_container_registry.acr.admin_username
}

output "registry_admin_password" {
  description = "Admin password for the ACR"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}