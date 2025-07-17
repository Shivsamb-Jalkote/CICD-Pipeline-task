output "cluster_name" {
  value = module.eks.cluster_name
}

output "update_kubeconfig_command" {
  value = "aws eks update-kubeconfig --region us-east-1 --name ${module.eks.cluster_name}"
}
