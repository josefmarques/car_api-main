module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.10.1"

  name               = format("%s-eks", local.project_id)
  kubernetes_version = "1.34"

  addons = {
    coredns = {
      before_compute = true
      most_recent    = true
    }
    eks-pod-identity-agent = {
      before_compute = true
      most_recent    = true
    }
    kube-proxy = {
      before_compute = true
      most_recent    = true
    }
    vpc-cni = {
      before_compute = true
      most_recent    = true
    }
  }

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    system = {
      ami_type       = "AL2023_ARM_64_STANDARD"
      instance_types = ["t4g.small"]

      min_size     = 1
      max_size     = 10
      desired_size = 2

      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }

      metadata_options = {
        http_put_response_hop_limit = 2
      }
    }
  }

  tags = local.tags
}
