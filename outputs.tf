# Outputs para serem consumidos pelo tc-golunch-serverless
output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.vpc_golunch.id
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas para VPC Link"
  value = [
    aws_subnet.subnet_public[0].id,
    aws_subnet.subnet_public[1].id,
    aws_subnet.subnet_public[2].id
  ]
}

output "nlb_arn" {
  description = "ARN do Network Load Balancer"
  value       = aws_lb.golunch_nlb.arn
}

output "nlb_listener_arn" {
  description = "ARN do Listener do NLB"
  value       = aws_lb_listener.golunch_api_listener.arn
}

output "vpc_link_security_group_id" {
  description = "ID do Security Group para VPC Link"
  value       = aws_security_group.vpc_link_sg.id
}

output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "Certificado CA do cluster EKS"
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
}