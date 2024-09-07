log_indexes = {
  "debug" = {
    daily_limit    = 30000
    retention_days = 15 # Set to 3 when CSM enables the log retention policy
    filter_query   = "status:debug"
  }

  "envoy" = {
    daily_limit    = 500000
    retention_days = 15 # Set to 7 when CSM enables the log retention policy
    filter_query   = "source:envoy"
  }

  "istio" = {
    daily_limit    = 25000
    retention_days = 15 # Set to 7 when CSM enables the log retention policy
    filter_query   = "source:istio"
  }

  "main" = {
    exclusion_filters = [
      {
        name         = "Exclude service:k8s.io"
        filter_query = "service:k8s.io"
      },
      {
        name         = "Exclude source:gcp.gce.subnetwork"
        filter_query = "source:gcp.gce.subnetwork"
      },
      {
        name = "Exclude source:gcp.gcs.backend.service check-probe"

        # The Ingress controller performs periodic checks of service account permissions by fetching a test resource from your Google Cloud project.
        # https://cloud.google.com/kubernetes-engine/docs/concepts/ingress#implementation_details

        filter_query = "source:gcp.gce.backend.service status:error @data.protoPayload.authorizationInfo.resource:projects/*/global/backendServices/k8s-ingress-svc-acct-permission-check-probe"
      },
      {
        name         = "Exclude service:monitoring.googleapis.com metrics service method"
        filter_query = "service:monitoring.googleapis.com method:google.monitoring.v3.metricservice.*"
      }
    ]
  }
}

teams = {
  "enabling-security" = {
    name        = "Enabling: Security"
    description = "Enabling team responsible for security."
  }

  "platform-datadog" = {
    name        = "Platform: Datadog"
    description = "Platform team responsible for Datadog."
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
