resource "aws_ecr_repository" "golunch" {
  name = "golunch"
}

resource "aws_ecr_repository" "golunch_core_service" {
  name = "golunch-core-service"
  
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    Name = "golunch-core-service"
    Service = "core"
  }
}

resource "aws_ecr_repository" "golunch_payment_service" {
  name = "golunch-payment-service"
  
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    Name = "golunch-payment-service"
    Service = "payment"
  }
}

resource "aws_ecr_repository" "golunch_operation_service" {
  name = "golunch-operation-service"
  
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    Name = "golunch-operation-service"
    Service = "operation"
  }
}