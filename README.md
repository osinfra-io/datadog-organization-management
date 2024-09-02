# <img align="left" width="45" height="45" src="https://github.com/user-attachments/assets/eb7f0847-4807-4a4a-a36a-86740477c660"> Datadog Organization: osinfra.io

**[GitHub Actions](https://github.com/osinfra-io/datadog-organization-management/actions):**

[![Dependabot](https://github.com/osinfra-io/datadog-organization-management/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/datadog-organization-management/actions/workflows/dependabot.yml)

## Repository Description

This repository is an example of IaC for managing a Datadog organization using [Terraform](https://www.terraform.io), concepts from [Team Topologies](https://teamtopologies.com/), and sensible default practices learned from software development.

## 🏭 Platform Information

- Documentation: [docs.osinfra.io](https://docs.osinfra.io/product-guides/datadog)
- Service Interfaces: [github.com](https://github.com/osinfra-io/datadog-organization-management/issues/new/choose)

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

We focus on the core fundamental practice of cloud engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [csm custom rules](https://docs.datadoghq.com/security/cloud_security_management/misconfigurations/custom_rules)
  - [open policy agent](https://www.openpolicyagent.org)
- [logs indexes](https://docs.datadoghq.com/logs/indexes)
- [organization settings](https://docs.datadoghq.com/account_management/org_settings)
- [teams](https://docs.datadoghq.com/account_management/teams)
- [users](https://docs.datadoghq.com/account_management/users)

### 📓 Terraform Documentation

<!-- BEGIN_TF_DOCS -->
#### Providers

| Name | Version |
|------|---------|
| datadog | 3.43.1 |

#### Resources

| Name | Type |
|------|------|
| [datadog_logs_index.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/logs_index) | resource |
| [datadog_logs_index_order.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/logs_index_order) | resource |
| [datadog_organization_settings.osinfra](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/organization_settings) | resource |
| [datadog_team.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/team) | resource |
| [datadog_team_membership.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/team_membership) | resource |
| [datadog_user.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/resources/user) | resource |
| [datadog_logs_indexes_order.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/data-sources/logs_indexes_order) | data source |
| [datadog_role.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/data-sources/role) | data source |
| [datadog_team.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/data-sources/team) | data source |
| [datadog_user.this](https://registry.terraform.io/providers/datadog/datadog/latest/docs/data-sources/user) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| datadog\_api\_key | Datadog API key | `string` | n/a | yes |
| datadog\_app\_key | Datadog APP key | `string` | n/a | yes |
| log\_indexes | Map of log indexes | ```map(object({ daily_limit = optional(number, 2000000) daily_limit_reset_time = optional(string, "07:00") daily_limit_reset_utc_offset = optional(string, "-04:00") daily_limit_warning_threshold_percentage = optional(number, 85) filter_query = optional(string, "") retention_days = optional(number, 15) exclusion_filters = optional(list(object({ name = optional(string, null) is_enabled = optional(bool, true) filter_query = optional(string, null) sample_rate = optional(number, 1) })), null) }))``` | n/a | yes |
| teams | Map of Datadog teams to create | ```map(object({ description = string name = string }))``` | n/a | yes |
| users | Map of Datadog users to create | ```map(object({ first_name = optional(string, null) last_name = optional(string, null) name = string role = string teams = optional(list(string), null) }))``` | n/a | yes |

#### Outputs

| Name | Description |
|------|-------------|
| organization\_id | The organization ID |
<!-- END_TF_DOCS -->
