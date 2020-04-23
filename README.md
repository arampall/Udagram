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


### Creation of Kubernetes Cluster
The kubernetes cluster is hosted on aws using kubeone and terraform. 

### Travis-ci as CI/CD
1. This github repository is integrated with travis-ci for continuous integration and deployment to the cluster.
2. The .travis.yml file is configured to perform the following tasks once a commit is pushed to the repo:
   a. Install docker-compose and kubectl in the travis-ci virtual env.
   b. Configure kubectl to connect with the remote kubernetes cluster by adding the cluster config file to kubectl setup.
   c. Build the project using the docker compose command.
   d. Use custom scripts (udacity-c3-deployment/deploy.sh) to push the built images to docker repo and apply the images to the                 kubernetes cluster with the help of kubectl. 




