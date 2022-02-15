#!/bin/bash

# Docker login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Docker build
docker build -t $FRONT_CONTAINER_NAME ../frontend

# Docker tag
docker tag $FRONT_CONTAINER_NAME $ECR_REPO

# Docker push
docker push $ECR_REPO