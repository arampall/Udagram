#!/bin/bash

# Login to docker repo using env variables 
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Save the docker images to the docker-hub repo
docker push rampalli6/udacity-frontend:local
docker push rampalli6/udacity-restapi-feed
docker push rampalli6/udacity-restapi-user
docker push rampalli6/reverseproxy

# Apply the deployment files the kubernetes clusters
kubectl apply -f k8s/backend-user-deployment.yaml
kubectl apply -f k8s/backend-feed-deployment.yaml
kubectl apply -f k8s/reverseproxy-deployment.yaml
kubectl apply -f k8s/frontend-deployment.yaml
