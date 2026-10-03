resource "random_password" "rds" {
  length           = 16
  special          = true
  override_special = "!#$&*()-_=+[]{}<>:?"
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.13.1"

  identifier = format("%s-rds", local.project_id)

  engine            = "postgres"
  engine_version    = "17.6"
  instance_class    = "db.m8g.large"
  allocated_storage = 5

  db_name  = "postgres"
  username = "postgres"
  port     = "5432"

  manage_master_user_password = false
  password                    = random_password.rds.result

  vpc_security_group_ids = [
    module.rds.security_group_id
  ]

  tags = local.tags

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  family = "postgres17"

  deletion_protection = false
}