teams = {
  "enabling-security" = {
    name        = "Enabling: Security"
    description = "Enabling team responsible for security."
  }

  "platform-google-cloud-kubernetes" = {
    name        = "Platform: Google Kubernetes Engine"
    description = "Platform team responsible for Google Kubernetes Engine."
  }

  "platform-google-cloud-landing-zone" = {
    name        = "Platform: Google Cloud Landing Zone"
    description = "Platform team responsible for the Google Cloud Landing Zone."
  }

  "stream-customer-trust" = {
    name        = "Stream: Customer Trust"
    description = "Stream team responsible for customer trust."
  }
}

users = {
  "brett@osinfra.io" = {
    name = "Brett Curtis"
    role = "Datadog Admin Role"
    teams = [
      "platform-google-cloud-kubernetes",
      "platform-google-cloud-landing-zone"
    ]
  }
}
