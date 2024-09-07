# Import
# https://developer.hashicorp.com/terraform/language/import

# Example for importing existing Datadog resources into Terraform state

# import {
#   to = datadog_organization_settings.osinfra
#   id = "068e40b4-ea1a-11ed-9b93-da7ad0900002"
# }

# import {
#   to = datadog_logs_index.this["main"]
#   id = "main"
# }

# import {
#   to = datadog_logs_index_order.this
#   id = data.datadog_logs_indexes_order.this.id
# }

# import {
#   for_each = var.teams
#   to       = datadog_team.this[each.key]
#   id       = data.datadog_team.this[each.key].id
# }

# import {
#   for_each = local.teams
#   to       = datadog_team_membership.this["${each.value.user}-${each.value.team}"]
#   id       = "${data.datadog_team.this[each.value.team].id}:${data.datadog_user.this[each.value.user].id}"
# }

# import {
#   for_each = var.users
#   to       = datadog_user.this[each.key]
#   id       = data.datadog_user.this[each.key].id
# }
