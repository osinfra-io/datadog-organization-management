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
