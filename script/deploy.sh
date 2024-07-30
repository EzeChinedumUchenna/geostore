#!/bin/bash


#BUILD_NUMBER=$(cat build_number.txt)

# Variables
REGION="us-east-2"  # Change to your AWS region..
ECR_REPOSITORY="637423571998.dkr.ecr.us-east-2.amazonaws.com/seamfixapp"  # Change to your ECR repository URI...
IMAGE_TAG="latest"

# Authenticate Docker to the ECR registry
#aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 637423571998.dkr.ecr.us-east-2.amazonaws.com




# Pull the latest image
#docker pull $ECR_REPOSITORY:$IMAGE_TAG
docker pull 637423571998.dkr.ecr.us-east-2.amazonaws.com/geostore-app:latest

# Stop and remove the existing container if it exists
if [ "$(docker ps -q -f name=seamfix-app)" ]; then
    docker stop seamfix-app
    docker rm seamfix-app
fi

# Run the new container
docker run -d --restart always -p 9191:9191 --name seamfix-app 637423571998.dkr.ecr.us-east-2.amazonaws.com/geostore-app:latest
#docker run -d --restart always -p 9191:9191 --name seamfixapp $ECR_REPOSITORY:$IMAGE_TAG

