variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
  sensitive   = true
}

variable "teams" {
  description = "Map of Datadog teams to create"
  type = map(object({
    description = string
    name        = string
  }))
}

variable "users" {
  description = "Map of Datadog users to create"
  type = map(object({
    first_name = optional(string, null)
    last_name  = optional(string, null)
    name       = string
    role       = string
    teams      = optional(list(string), null)
  }))
}
