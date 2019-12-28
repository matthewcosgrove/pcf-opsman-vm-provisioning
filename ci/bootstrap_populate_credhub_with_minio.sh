#!/bin/bash
set -eu
credhub set -t value -n /concourse/main/minio_url -v $MINIO_URL
credhub set -t value -n /concourse/main/minio_region -v $MINIO_REGION
credhub set -t value -n /concourse/main/minio_pivnet_products_bucket -v $MINIO_PIVNET_PRODUCTS_BUCKET
