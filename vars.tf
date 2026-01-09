# Projeto

variable "projectName" {
  default = "golunch-terraform-infra"
}

variable "region_default" {
  default = "us-east-1"
}

variable "cidr_vpc" {
  default = "10.0.0.0/16"
}

# Tags padrão

variable "tags" {
  default = {
    Name = "golunch-terraform-infra"
  }
}

# Conta AWS

variable "account" {
  type        = string
  description = "Conta logada da AWS"
}


# ROLES DE LAB

# locals {
#   principal_arn = "arn:aws:iam::${var.account}:role/voclabs"
#   lab_role      = "arn:aws:iam::${var.account}:role/LabRole"
# }

# output "principal_arn" {
#   value = local.principal_arn
# }

# output "lab_role" {
#   value = local.lab_role
# }

# EKS Access Configuration

variable "policy_arn" {
  description = "EKS Cluster Access Policy"
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "accessConfig" {
  description = "EKS authentication mode"
  default     = "API_AND_CONFIG_MAP"
}
