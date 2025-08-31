resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node_group-${var.projectName}"
  node_role_arn   = local.lab_role
  subnet_ids      = aws_subnet.subnet_public[*].id
  disk_size       = 20
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}