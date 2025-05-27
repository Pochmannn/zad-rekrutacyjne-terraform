#!/bin/bash

mc alias set myminio-s3 http://$(terraform output -raw minio_url) $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
mc mb myminio-s3/$S3_BUCKET_NAME
mc ilm tier add s3 myminio-s3 S3TIER --endpoint https://s3.amazonaws.com \
     --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY --bucket $S3_BUCKET_NAME --prefix mys3prefix/ \
     --storage-class "STANDARD" --region eu-central-1
mc mirror s3/$S3_BUCKET_NAME myminio-s3/$S3_BUCKET_NAME
