# Access Entry para eks_admin_role
resource "aws_eks_access_entry" "access_entry" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = aws_iam_role.eks_admin_role.arn

  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = aws_iam_role.eks_admin_role.arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

# Access Entry para git-terraform-role (usado pelos workflows GitHub Actions)
resource "aws_eks_access_entry" "git_terraform_role_entry" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::032811251961:role/git-terraform-role"

  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "git_terraform_role_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::032811251961:role/git-terraform-role"

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

# Access Entry para IAM User admin (acesso via console AWS)
resource "aws_eks_access_entry" "admin_user_entry" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::032811251961:user/admin"

  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_user_policy" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::032811251961:user/admin"

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
