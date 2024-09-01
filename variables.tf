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

variable "log_indexes" {
  description = "Map of log indexes"
  type = map(object({
    daily_limit                              = optional(number, 2000000)
    daily_limit_reset_time                   = optional(string, "07:00")
    daily_limit_reset_utc_offset             = optional(string, "-04:00")
    daily_limit_warning_threshold_percentage = optional(number, 85)
    filter_query                             = optional(string, "")
    retention_days                           = optional(number, 15)

    exclusion_filters = optional(list(object({
      name         = optional(string, null)
      is_enabled   = optional(bool, true)
      filter_query = optional(string, null)
      sample_rate  = optional(number, 1)
    })), null)
  }))
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
