output "ssm_parameter_arn" {
  description = "ARN of the SSM parameter created by this deployment"
  value       = aws_ssm_parameter.jpbarto_app_ns_key.arn
}

output "gitops_application_release" {
  description = "Git tag or branch deployed to the GitOps application"
  value       = var.gitops_target_revision
}
