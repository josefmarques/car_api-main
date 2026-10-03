module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.22.0"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  observability_tag = null

  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    set = [
      {
        name  = "vpcId"
        value = module.vpc.vpc_id
      }
    ]
  }
  enable_cluster_autoscaler = true
  cluster_autoscaler = {
    chart_version = "9.54.0"
  }

  enable_metrics_server   = true
  enable_external_secrets = true
  enable_external_dns     = true
  external_dns_route53_zone_arns = [
    "arn:aws:route53:::hostedzone/Z01369533JWLF8Z0FCZQF"
  ]
  external_dns = {
    values = [
      <<-EOT
        provider: aws
        policy: sync
      EOT
    ]
  }

  tags = local.tags
}