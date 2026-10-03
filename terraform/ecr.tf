locals {
  repositories = [
    "car-api",
    "car-api-mkdocs"
  ]
}

module "ecr" {
  for_each = toset(local.repositories)

  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 3.1.0"

  create_lifecycle_policy = false

  repository_name                 = each.key
  repository_image_tag_mutability = "MUTABLE" # alterar para IMMUTABLE depois de acertar o CI
  repository_force_delete         = true

  tags = local.tags
}
