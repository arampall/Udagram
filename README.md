# Udagram Image Filtering Microservice

The project is split into following parts:
1. [The Simple Frontend](/udacity-c3-frontend)
A basic Ionic client web application which consumes the RestAPI Backend. 
2. [The RestAPI Feed Backend](/udacity-c3-restapi-feed), a Node-Express feed microservice.
3. [The RestAPI User Backend](/udacity-c3-restapi-user), a Node-Express user microservice.
4. A reverseproxy nginx server to forward requests to the corresponding the backend microservice.

## Project Details

### Application Endpoint
[https://myudagram.com/home](http://ad64965fd470d46c694b62bfb0b947d4-2089795939.us-east-1.elb.amazonaws.com:8100/)

### Docker repo
Each module has a docker file with the instructions required to build the service.
1. To build the docker image, go to the module directory and run the following command.
    For Example, to build the image for feed service, go to the (/udacity-c3-restapi-feed) and run
    ```bash
    docker build -t <your_dockerhub_username_lowercase>/<image_name> .
    ```
2. To build all the images for the project using docker-compose, use the docker-compose-build.yaml file in udacity-c3-deployment/docker    and run the following command
   ```bash
    docker-compose -f docker-compose-build.yaml build --parallel
    ```
3. All the docker images are stored in the [Docker Repo](https://hub.docker.com/u/rampalli6)


### Kubernetes Cluster
1. The kubernetes cluster is hosted on aws using kubeone and terraform.
2. kubectl is installed and configured to manage the application in the cluster.
3. The deployment files, services file, config files and the secrets files are updated and applied to cluster using the following command.
   ```bash
    kubectl apply -f <path-to-yaml-file>
    ``` 
4. The pods, deployments and services are monitored using,
   ```bash
    kubectl get pods
    kubectl get deployments
    kubectl get services
    ```
#### Rolling Updates:
       When the image of any one of the deployments is updated and applied, a new container is created in a pod and replaces the existing pod. This process continues until all the pods are updated with the changes.
       Below is one of the instance when the changes are applied to the backend-feed deployment.
       ```bash
          $ kubectl get pods
          NAME                            READY   STATUS              RESTARTS   AGE
          backend-feed-67977d4ff7-ms957   1/1     Running             0          2d
          backend-feed-67977d4ff7-rmqxm   1/1     Terminating         0          5h36m
          backend-feed-7668f44f6b-6zp8l   0/1     ContainerCreating   0          1s
          backend-feed-7668f44f6b-hk9fs   1/1     Running             0          25s             
       ```
#### A/B deployments
This can be achieved by having 2 different deployment.yaml files have the label pointing to a single service.yaml file. 
Based on the traffic, the service serves either of the deployment versions.  


### Travis-ci as CI/CD
This github repository is integrated with travis-ci for continuous integration and deployment to the cluster. The .travis.yml file is configured to perform the following tasks once a commit is pushed to the repo:
1. Install docker-compose and kubectl in the travis-ci virtual env.
2. Configure kubectl to connect with the remote kubernetes cluster by adding the cluster config file to kubectl setup.
3. Build the project using the docker compose command.
4. Use custom scripts (udacity-c3-deployment/deploy.sh) to push the built images to docker repo and apply the images to the kubernetes cluster with the help of kubectl. 
The docker repo credentials and the kubernetes cluster config files are stored as environment variable in travis-ci



