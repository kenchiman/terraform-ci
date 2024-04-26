output "connection" {
  description = "Event Hub Namespace default primary connection string."
  value       = azurerm_eventhub_namespace.example.default_primary_connection_string
  sensitive   = true
}

# output "connection" {
#   description = "Event Hub Namespace default primary connection string."
#   value       = azurerm_eventhub_authorization_rule.example.primary_connection_string
#   sensitive   = true
# }

output "evh_name" {
  description = "Event Hub Name"
  value       = azurerm_eventhub.example.name
}