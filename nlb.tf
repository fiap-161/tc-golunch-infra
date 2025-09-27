# Network Load Balancer para integração com API Gateway
resource "aws_lb" "golunch_nlb" {
  name               = "golunch-api-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [
    aws_subnet.subnet_public[0].id,
    aws_subnet.subnet_public[1].id,
    aws_subnet.subnet_public[2].id
  ]

  enable_deletion_protection = false

  tags = var.tags
}

# Security Group para VPC Link
resource "aws_security_group" "vpc_link_sg" {
  name_prefix = "golunch-vpc-link-"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow HTTP from API Gateway VPC Link"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_vpc]
  }

  ingress {
    description = "Allow custom port from API Gateway VPC Link"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.cidr_vpc]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "golunch-vpc-link-sg"
  })
}

# Target Group para EKS NodePort
resource "aws_lb_target_group" "golunch_api_tg" {
  name     = "golunch-api-tg"
  port     = 30080  # NodePort da aplicação
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/ping"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, {
    Name = "golunch-api-tg"
  })
}

# Listener na porta 80 para API Gateway
resource "aws_lb_listener" "golunch_api_listener" {
  load_balancer_arn = aws_lb.golunch_nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.golunch_api_tg.arn
  }
}

# Auto Scaling Group attachment
data "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = aws_eks_node_group.cluster.node_group_name
}

data "aws_autoscaling_group" "eks_asg" {
  name = data.aws_eks_node_group.node_group.resources[0].autoscaling_groups[0].name
}

resource "aws_autoscaling_attachment" "golunch_api_asg_attachment" {
  autoscaling_group_name = data.aws_autoscaling_group.eks_asg.name
  lb_target_group_arn    = aws_lb_target_group.golunch_api_tg.arn
}