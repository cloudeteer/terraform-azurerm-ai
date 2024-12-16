output "endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "primary_access_key" {
  description = "A primary access key which can be used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.primary_access_key
}

output "secondary_access_key" {
  description = "The secondary access key which can be used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.secondary_access_key
}
