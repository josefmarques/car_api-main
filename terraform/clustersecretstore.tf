# resource "kubernetes_manifest" "cluster-secret-store" {
#   manifest = {
#     "apiVersion" = "external-secrets.io/v1beta1"
#     "kind"       = "ClusterSecretStore"
#     "metadata" = {
#       "name"      = "aws-ssm"
#     }
#     "spec" = {
#       "provider" = {
#         "aws" = {
#           "service" = "ParameterStore"
#           "region"  = "us-east-1"
#         }
#       }
#     }
#   }

#   depends_on = [ module.eks_blueprints_addons ]
# }