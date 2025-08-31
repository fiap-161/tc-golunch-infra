resource "aws_eks_cluster" "cluster" {
  name = "eks-${var.projectName}"

  access_config {
    authentication_mode = var.accessConfig
  }

  role_arn = local.lab_role
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_public[0].id,
      aws_subnet.subnet_public[1].id,
      aws_subnet.subnet_public[2].id,

    ]
  }
}