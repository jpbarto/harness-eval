variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources into (e.g. us-east-1)"
}

variable "env_name" {
  type        = string
  description = "Harness environment name; used to name the GitOps application as guestbook-<env_name>"
}

variable "harness_account_id" {
  type        = string
  description = "Harness account ID"
}

variable "harness_org_id" {
  type        = string
  description = "Harness organisation identifier"
}

variable "harness_project_id" {
  type        = string
  description = "Harness project identifier"
}

variable "harness_gitops_agent_id" {
  type        = string
  description = "Identifier of the Harness GitOps agent"
}

variable "harness_gitops_cluster_id" {
  type        = string
  description = "Identifier of the Harness GitOps cluster"
}

variable "gitops_target_revision" {
  type        = string
  description = "Git tag or branch of the application to deploy (e.g. rel09)"
}

variable "gitops_target_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy the guestbook application into, sourced from the Harness org-level variable 'squadName'"
}
