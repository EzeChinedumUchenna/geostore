#!/bin/bash

# Variables
REGION="us-east-2"  # Change to your AWS region
ECR_REPOSITORY="637423571998.dkr.ecr.us-east-2.amazonaws.com/seamfixapp"  # Change to your ECR repository URI
IMAGE_TAG="latest"

# Authenticate Docker to the ECR registry
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY

# Pull the latest image
docker pull $ECR_REPOSITORY:$IMAGE_TAG

# Stop and remove the existing container if it exists
if [ "$(docker ps -q -f name=seamfixapp)" ]; then
    docker stop seamfixapp
    docker rm seamfixapp
fi

# Run the new container
docker run -d --restart always -p 9191:9191 --name seamfixapp $ECR_REPOSITORY:$IMAGE_TAG

