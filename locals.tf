# Local Values
# https://www.terraform.io/language/values/locals

locals {
  teams = { for team in flatten([

    # This will iterate over the users map and return a list of maps based of the values of the teams
    # that includes the group key.

    for user_key, user in var.users : [
      for team in user.teams : {
        user = user_key
        team = team
      }
    ]
  ]) : "${team.user}-${team.team}" => team }
}
