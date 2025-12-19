#!/bin/bash
set -euo pipefail

BUCKET_NAME="${1}"
REGION="${2}"

if [[ -z "$BUCKET_NAME" || -z "$REGION" ]]; then
  echo "Usage: $0 <bucket-name> <region>"
  exit 1
fi

echo "[INFO] Creating s3 bucket $BUCKET_NAME in $REGION region..."
if [[ "$REGION" == "us-east-1" ]]; then
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME"
else
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$REGION" \
    --create-bucket-configuration LocationConstraint="$REGION"
fi

echo "[INFO] Waiting for bucket to become available..."
aws s3api wait bucket-exists \
    --bucket "$BUCKET_NAME"

echo "[INFO] Enabling versioning..."
aws s3api put-bucket-versioning \
    --bucket "$BUCKET_NAME" \
    --versioning-configuration 'Status=Enabled'
