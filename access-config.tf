resource "aws_eks_access_entry" "access_entry" {
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = local.principal_arn
  kubernetes_groups = ["fiap"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks-policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = var.policy_arn
  principal_arn = local.principal_arn

  access_scope {
    type = "cluster"
  }
}