provider "aws" {
  region = var.aws_region
}

resource "aws_ssm_parameter" "jpbarto_app_ns_key" {
  name  = "jpbarto-app-ns-key"
  type  = "String"
  value = "jpbarto-app-ns-value-rev7"

  tags = {
    squad = "jpbarto"
  }
}
