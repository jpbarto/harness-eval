provider "aws" {
  region = "eu-west-1"
}

# Credentials read from HARNESS_ACCOUNT_ID and HARNESS_PLATFORM_API_KEY env vars
provider "harness" {}

variable "env_name" {
  type        = string
  description = "Harness environment name; used to name the GitOps application as guestbook-<env_name>"
}

variable "harness_account_id" {
  type        = string
  description = "Harness account ID"
}

variable "harness_gitops_agent_id" {
  type        = string
  description = "Identifier of the Harness GitOps agent"
}

variable "harness_gitops_repo_id" {
  type        = string
  description = "Identifier of the Harness GitOps repository connector"
}

variable "gitops_target_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy the guestbook application into"
  default     = "default"
}

resource "aws_ssm_parameter" "jpbarto_app_ns_key" {
  name      = "jpbarto-app-ns-key"
  type      = "String"
  value     = "jpbarto-app-ns-value-rev7"
  overwrite = true
}

resource "harness_platform_gitops_app" "guestbook" {
  account_id      = var.harness_account_id
  org_id          = "default"
  project_id      = "jpbartoapplication"
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
        path            = "guestbook"
        repo_url        = "https://github.com/jpbarto/harness-eval"
        target_revision = "HEAD"
      }
    }
  }
}
