module "rds" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3.1"

  name        = "rds"
  description = "Security Group for Postgres RDS instance (pycodebr)"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.eks.node_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}
