# Credentials read from HARNESS_ACCOUNT_ID and HARNESS_PLATFORM_API_KEY env vars
provider "harness" {}

resource "harness_platform_gitops_applications" "guestbook" {
  org_id               = var.harness_org_id
  project_id           = var.harness_project_id
  agent_id             = var.harness_gitops_agent_id
  cluster_id           = var.harness_gitops_cluster_id
  name                 = "guestbook-${var.env_name}"
  kind                 = "argocd"
  skip_repo_validation = true

  request_cascade             = true
  request_propagation_policy = "foreground"

  application {
    metadata {
      name = "guestbook-${var.env_name}"
    }
    spec {
      sources {
        repo_url        = "https://github.com/jpbarto/harness-eval"
        target_revision = "rel08"
        ref             = "values"
      }
      sources {
        repo_url        = "https://github.com/jpbarto/harness-eval"
        target_revision = "rel08"
        path            = "helm/guestbook"
        helm {
          value_files = ["$values/envs/${var.env_name}/values.yaml"]
        }
      }
      destination {
        namespace = var.gitops_target_namespace
        server    = "https://kubernetes.default.svc"
      }
      sync_policy {
        sync_options = [
          "PrunePropagationPolicy=foreground",
          "CreateNamespace=true",
          "Validate=true",
          "PruneLast=false",
          "ApplyOutOfSyncOnly=false",
          "FluxSubsystem=false",
          "AutoCreateFluxResources=false",
          "Replace=false",
          "retry=false",
          "applicationsSync=undefined",
          "preserveResourcesOnDeletion=false",
        ]
      }
    }
  }
}
