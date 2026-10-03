module "rds-ssm-parameter" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "~> 2.0.1"

  name        = format("/%s/car-api/rds/password", local.project_id)
  value       = random_password.rds.result
  secure_type = true
}

resource "random_password" "jwt_secret_key" {
  length  = 32
  special = false
}

module "app-jwt-secret-key" {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "~> 2.0.1"

  name        = format("/%s/car-api/app/jwt_secret_key", local.project_id)
  value       = random_password.jwt_secret_key.result
  secure_type = true
}
