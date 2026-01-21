resource "aws_secretsmanager_secret" "golunch_ecr" {
  name        = "golunch/ecr-uri-1"
  description = "URI do repositório ECR usado pela aplicação GoLunch"
}

resource "aws_secretsmanager_secret_version" "golunch_ecr_uri" {
  secret_id     = aws_secretsmanager_secret.golunch_ecr.id
  secret_string = aws_ecr_repository.golunch.repository_url
}

resource "aws_secretsmanager_secret" "golunch_s3_imgs" {
  name        = "golunch/s3-uri-1"
  description = "URL pública do bucket S3 para armazenar imagens"
}

resource "aws_secretsmanager_secret_version" "golunch_s3_uri" {
  secret_id     = aws_secretsmanager_secret.golunch_s3_imgs.id
  secret_string = aws_s3_bucket.images.bucket_regional_domain_name
}