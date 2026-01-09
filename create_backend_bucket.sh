#!/bin/bash
set -euo pipefail

REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="s3-golunch-infra-terraform-${ACCOUNT_ID}"

echo "🔍 Verificando bucket: $BUCKET_NAME"

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "✅ Bucket $BUCKET_NAME já existe e pertence a esta conta."
else
  echo "🚀 Criando bucket $BUCKET_NAME em $REGION..."

  if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket \
      --bucket "$BUCKET_NAME"
  else
    aws s3api create-bucket \
      --bucket "$BUCKET_NAME" \
      --create-bucket-configuration LocationConstraint="$REGION"
  fi

  echo "🔄 Ativando versionamento..."
  aws s3api put-bucket-versioning \
    --bucket "$BUCKET_NAME" \
    --versioning-configuration Status=Enabled

  echo "✅ Bucket criado com sucesso."
fi
