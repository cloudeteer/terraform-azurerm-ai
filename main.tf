locals {
  virtual_network_id    = one(regex("(.*?/virtualNetworks/[^/]+)", var.subnet_id))
  virtual_network_name  = one(regex("virtualNetworks/([^/]+)", var.subnet_id))
  private_dns_zone_name = var.kind == "OpenAI" ? "privatelink.openai.azure.com" : "privatelink.cognitiveservices.azure.com"
}

resource "azurerm_cognitive_account" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  kind                          = var.kind
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  custom_subdomain_name         = var.custom_subdomain_name
}

resource "azurerm_cognitive_deployment" "this" {
  for_each = { for model in var.models : model.name => model }

  cognitive_account_id = azurerm_cognitive_account.this.id

  name            = each.value.name
  rai_policy_name = each.value.rai_policy_name

  model {
    format  = each.value.format
    name    = each.value.name
    version = each.value.version
  }

  sku {
    name     = each.value.sku.name
    capacity = each.value.sku.capacity
  }
}

resource "azurerm_private_dns_zone" "this" {
  name                = local.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


resource "azurerm_private_endpoint" "this" {
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "pl-${var.name}"
    private_connection_resource_id = azurerm_cognitive_account.this.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                = local.virtual_network_name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = local.virtual_network_id
}
