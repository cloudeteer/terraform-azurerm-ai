<!-- markdownlint-disable first-line-h1 no-inline-html -->

> [!NOTE]
> This repository is publicly accessible as part of our open-source initiative. We welcome contributions from the community alongside our organization's primary development efforts.

---

# terraform-module-template

[![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://github.com/cloudeteer/terraform-module-template/releases)

Terraform Module Template

<!-- BEGIN_TF_DOCS -->
## Usage

This example demonstrates the usage of this Terraform module with default settings.

```hcl
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
```

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.0)



## Resources

The following resources are used by this module:

- [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) (resource)
- [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) (resource)
- [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) (resource)
- [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)
- [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_kind"></a> [kind](#input\_kind)

Description: Specifies the type of Cognitive Service Account that should be created. Possible values are:

- `Academic`
- `AnomalyDetector`
- `Bing.Autosuggest.v7`
- `Bing.Autosuggest`
- `Bing.CustomSearch`
- `Bing.Search.v7`
- `Bing.Search`
- `Bing.Speech`
- `Bing.SpellCheck.v7`
- `Bing.SpellCheck`
- `CognitiveServices`
- `ComputerVision`
- `ContentModerator`
- `ContentSafety`
- `CustomSpeech`
- `CustomVision.Prediction`
- `CustomVision.Training`
- `Emotion`
- `Face`
- `FormRecognizer`
- `ImmersiveReader`
- `LUIS.Authoring`
- `LUIS`
- `MetricsAdvisor`
- `OpenAI`
- `Personalizer`
- `QnAMaker`
- `Recommendations`
- `SpeakerRecognition`
- `Speech`
- `SpeechServices`
- `SpeechTranslation`
- `TextAnalytics`
- `TextTranslation
- `WebLM`
`

Type: `string`

### <a name="input_location"></a> [location](#input\_location)

Description: Specifies the supported Azure location where the resource exists.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: Specifies the name of the Cognitive Service Account.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The name of the resource group in which the Cognitive Service Account is created.

Type: `string`

### <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name)

Description: Specifies the SKU Name for this Cognitive Service Account. Possible values are `F0`, `F1`, `S0`, `S`, `S1`, `S2`, `S3`, `S4`, `S5`, `S6`, `P0`, `P1`, `P2`, `E0` and `DC0`.

Type: `string`

### <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id)

Description: The ID of the subnet which should be able to access this Cognitive Account.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name)

Description: The subdomain name used for token-based authentication.

Type: `string`

Default: `null`

### <a name="input_models"></a> [models](#input\_models)

Description: value

Type: `list(any)`

Default: `[]`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: Whether public network access is allowed for the Cognitive Account.

Type: `bool`

Default: `false`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A mapping of tags which should be assigned to all resources in this module.

Type: `map(string)`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_endpoint"></a> [endpoint](#output\_endpoint)

Description: The endpoint used to connect to the Cognitive Service Account.

### <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key)

Description: A primary access key which can be used to connect to the Cognitive Service Account.

### <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key)

Description: The secondary access key which can be used to connect to the Cognitive Service Account.
<!-- END_TF_DOCS -->

## Contributions

We welcome all kinds of contributions, whether it's reporting bugs, submitting feature requests, or directly contributing to the development. Please read our [Contributing Guidelines](CONTRIBUTING.md) to learn how you can best contribute.

Thank you for your interest and support!

## Copyright and license

<img width=200 alt="Logo" src="https://raw.githubusercontent.com/cloudeteer/cdt-public/main/img/cdt_logo_orig_4c.svg">

© 2024 CLOUDETEER GmbH

This project is licensed under the [MIT License](LICENSE).
