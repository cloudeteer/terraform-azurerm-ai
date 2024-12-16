resource "azurerm_resource_group" "example" {
  name     = "rg-example-dev-euw-01"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-euw-01"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  address_space = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "example" {
  name                 = "snet-example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name

  address_prefixes = ["10.1.0.0/16"]
}


module "example" {
  source = "cloudeteer/ai/azurerm"

  name                = "oai-example-dev-euw-01"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  subnet_id = azurerm_subnet.example.id

  kind     = "OpenAI"
  sku_name = "S0"

  models = [
    {
      rai_policy_name = "Microsoft.Default"
      format          = "OpenAI"
      name            = "gpt-4o-mini"
      version         = "2024-07-18"
      sku = {
        name     = "GlobalStandard"
        capacity = 100
      }
    }
  ]
}
