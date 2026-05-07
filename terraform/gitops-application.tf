# Credentials read from HARNESS_ACCOUNT_ID and HARNESS_PLATFORM_API_KEY env vars
provider "harness" {}

resource "harness_platform_gitops_app" "guestbook" {
  account_id      = var.harness_account_id
  org_id          = var.harness_org_id
  project_id      = var.harness_project_id
  agent_id        = var.harness_gitops_agent_id
  repo_identifier = var.harness_gitops_repo_id

  app {
    metadata {
      name      = "guestbook-${var.env_name}"
      namespace = "argocd"
    }
    spec {
      destination {
        namespace = var.gitops_target_namespace
        server    = "https://kubernetes.default.svc"
      }
      source {
        path            = "helm/guestbook"
        repo_url        = "https://github.com/jpbarto/harness-eval"
        target_revision = "rel08"
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
