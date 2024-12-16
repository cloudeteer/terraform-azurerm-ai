variable "custom_subdomain_name" {
  type        = string
  description = "The subdomain name used for token-based authentication."
  default     = null
}

variable "kind" {
  type        = string
  description = <<-EOD
    Specifies the type of Cognitive Service Account that should be created. Possible values are:

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
  EOD
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "models" {
  type        = list(any)
  description = "value"
  default     = []
}

variable "name" {
  type        = string
  description = "Specifies the name of the Cognitive Service Account."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for the Cognitive Account."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Cognitive Service Account is created."
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for this Cognitive Service Account. Possible values are `F0`, `F1`, `S0`, `S`, `S1`, `S2`, `S3`, `S4`, `S5`, `S6`, `P0`, `P1`, `P2`, `E0` and `DC0`."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet which should be able to access this Cognitive Account."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags which should be assigned to all resources in this module."
  default     = null
}
