# DataDog Provider
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs

terraform {
  required_providers {
    datadog = {
      source = "datadog/datadog"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Datadog Logs Index Order Data Source
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/data-sources/logs_index_order

data "datadog_logs_indexes_order" "this" {}

# Datadog Role Data Source
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/data-sources/role

data "datadog_role" "this" {
  for_each = toset(
    [
      "Datadog Admin Role",
      "Datadog Read Only Role",
      "Datadog Standard Role"
  ])

  filter = each.key
}

data "datadog_team" "this" {
  for_each = var.teams

  filter_keyword = each.key
}

data "datadog_user" "this" {
  for_each = var.users

  filter = each.key
}

# Datadog Logs Index Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/logs_index

resource "datadog_logs_index" "this" {
  for_each = var.log_indexes


  daily_limit = each.value.daily_limit

  daily_limit_reset {
    reset_time       = each.value.daily_limit_reset_time
    reset_utc_offset = each.value.daily_limit_reset_utc_offset
  }

  daily_limit_warning_threshold_percentage = each.value.daily_limit_warning_threshold_percentage

  filter {
    query = each.value.filter_query
  }

  name           = each.key
  retention_days = each.value.retention_days

  dynamic "exclusion_filter" {
    for_each = each.value.exclusion_filters == null ? [] : each.value.exclusion_filters
    content {
      name       = exclusion_filter.value.name
      is_enabled = exclusion_filter.value.is_enabled
      filter {
        query       = exclusion_filter.value.filter_query
        sample_rate = exclusion_filter.value.sample_rate
      }
    }
  }
}

# Datadog Logs Index Order Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/logs_index_order

resource "datadog_logs_index_order" "this" {
  name = "logs-index-order"
  indexes = [
    datadog_logs_index.this["debug"].id,
    datadog_logs_index.this["envoy"].id,
    datadog_logs_index.this["k8s"].id,
    datadog_logs_index.this["istio"].id,
    datadog_logs_index.this["subnet"].id,
    datadog_logs_index.this["main"].id
  ]
}

# Datadog Organization Settings Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/organization_settings

resource "datadog_organization_settings" "osinfra" {
  name = "osinfra.io"

  settings {
    private_widget_share        = false
    saml_autocreate_access_role = "st"

    saml {
      enabled = false
    }

    saml_autocreate_users_domains {
      domains = []
      enabled = false
    }

    saml_idp_initiated_login {
      enabled = false
    }

    saml_strict_mode {
      enabled = false
    }
  }
}

# Datadog Team Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team

resource "datadog_team" "this" {
  for_each = var.teams

  description = each.value.description
  handle      = each.key
  name        = each.value.name
}

# Datadog Team Membership Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/team_membership

resource "datadog_team_membership" "this" {
  for_each = local.teams

  role    = "admin"
  team_id = data.datadog_team.this[each.value.team].id
  user_id = data.datadog_user.this[each.value.user].id
}

# Datadog User Resource
# https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/user

resource "datadog_user" "this" {
  for_each = var.users

  email = each.key
  name  = each.value.name
  roles = [data.datadog_role.this[each.value.role].id]
}
