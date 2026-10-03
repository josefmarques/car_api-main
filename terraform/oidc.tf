module "oidc_gitlab_com" {
  source  = "gitlab.com/gitlab-com/terraform-gitlab-aws-oidc/local"
  version = "~> 1.3.0"

  oidc_roles = {
    main = {
      role_name   = "GitLabCIOIDC-pycodebr-car-api-main"
      role_path   = "/ci/"
      match_field = "sub"
      match_value = ["project_path:pycodebr/car_api:ref_type:branch:ref:main"]
      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
      ]
    }
  }
}
