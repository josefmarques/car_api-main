resource "flux_bootstrap_git" "pycodebr_eks" {
  embedded_manifests = true
  path               = "clusters/pycodebr-eks"
}