# The Approach Used here Includes Volume in backend for Read/Write operations.

# Architecture Diagram

![image](https://github.com/signavio-hiring/coding-challenge-rahul-awari/assets/47710382/d255cf1f-8bd8-413b-aede-388c47a44d75)

# Working Demo 

https://github.com/signavio-hiring/coding-challenge-rahul-awari/assets/47710382/829d18d0-bc06-4eaa-883c-18dee9499177


## Prerequisite

  * Docker Desktop/Engine
  * Minikube
  * Powershell
  * Kubernetes

## Steps to test locally

  1. Clone the repository
     ``` bash
     git clone -b approach-volume https://github.com/signavio-hiring/coding-challenge-rahul-awari.git
     ```
  2. Clone the repository
     ``` bash
     cd .\coding-challenge-rahul-awari\
     ```
     
  3. To test in Docker Engine and local host , Ensure Docker Engine is running in background
     ```bash
     docker compose up --build -d
     ```
     Once both containers are started , Result can be tested in localhost
     http://localhost:8080/api/HttpTriggerReader?json=[{"id":"1","message":"Hello World"}]
     http://localhost:9000/api/HttpTriggerReverse

    ** Please Note Input can be dynamically rendered by changing the array json in localhost:8080 and refreshing results in localhost:9000**

  4. Start Minikube
     ```bash
     minikube start
     ```
     
  5. Deploy YAML files to Minikube cluster
     ```bash
     kubectl apply -f readercontainer-deployment.yaml,
     kubectl apply -f readercontainer-service.yaml,
     kubectl apply -f reversecontainer-deployment.yaml,
     kubectl apply -f reversecontainer-service.yaml,
     kubectl apply -f shared-data-persistentvolumeclaim.yaml
     ```

  6. Verify the Deployments,pods and service
     ```bash
     kubectl get deployments
     kubectl get pods
     kubectl get services
     ```
  7. Start Services
     ```bash
     minikube service readercontainer
     minikube service reversecontainer
     ```
  ### Once both the services are started input can be added and result can be observed service IP

    ** http://<Reader container service IP>/api/HttpTriggerReader?json=[{"id":"1","message":"HelloWorld"}] **
    ** http://<Reverse container service IP>/api/HttpTriggerReverse **

    JSON ARRAY CAN BE DYNAMICALLY RENDERED AND REVERSED RESULTS CAN BE SEEN IN REVERSE HYPERLINK

  ## Steps to Run using Powershell script

   ```powershell
   .\script.ps1
   ```
   After Executing the script 2 services are started as there is a delay please refresh , once the function is running 
   
     readercontainer -  ** http://<service IP>/api/HttpTriggerReader?json=[{%22id%22:%221%22,%22message%22:%22SAP%20SIGNAVIO%22}] **
     reversecontainer - ** http://<service IP>/api/HttpTriggerReverse **
  ## Reference 

   1. Creation of Http Trigger function and dockerizing them.
      * [Dockerize Http Function Apps Azure](https://learn.microsoft.com/en-us/azure/azure-functions/functions-deploy-container-apps?tabs=acr%2Cbash&pivots=programming-language-python)
      * [Docker file reference](https://docs.docker.com/reference/dockerfile/)

   2. Using Volumes
      * [Docker volume Example Medium](https://dev.to/doziestar/a-comprehensive-guide-to-docker-volumes-4d9h)
      * [Docker Volume Documentation](https://docs.docker.com/storage/volumes/)
      * [PVC and Volumes](https://youtu.be/OulmwTYTauI?si=Uy-3VLMHwj3uFVNt)
      * [PVC and Volumes](https://youtu.be/0swOh5C3OVM?si=KfSeQnTUmJZI_kws)

   3. Creating Public Images and pushing to Docker Hub
      * [Pushing Image to dockerhub](https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc)
      * [reader-dockerhub-repo:latest Dockerhub Image](https://hub.docker.com/repository/docker/rahulawari683/reader-dockerhub-repo/general)
      * [reverse-dockerhub-repo:latest Dockerhub Image](https://hub.docker.com/repository/docker/rahulawari683/reverse-dockerhub-repo/general)

   4. Drafting Docker Compose File
      * [Docker Compose File](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app?tabs=azure-cli)
      * [Cluster IP](https://youtu.be/JBS6Ub0bR80?si=ykXRQcR5DB8rTrl-)

   5. Converting Docker File to YAML file for kubernetes deployment (VERY USEFUL TOOL WHICH I DISCOVERED)
      * [Convert Docker File to YAML file using kompose](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)

   6. Using Minikube for testing locally
      * [Minikube Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-use-minikube-for-local-kubernetes-development-and-testing)
      * [Medium Document Minikube](https://itnext.io/how-to-experiment-locally-on-kubernetes-with-minikube-and-your-local-dockerfiles-48833fcd90c9)

   7. ChatGpt
      * [Chapgpt](https://chat.openai.com/)
     
  ## Scope of Improvement

   1. Add multiple replicas and RollingUpdate feature to make it more scaleable and reduce downtime.
   2. Currently the read and write operation to volume does not updates automatically , user needs to refresh to observe changes.
   3. Delay observed when automated through script as hyperlink might be active but resources might not be allotted.
   4. Old Data stored in volume.
   5. Can be deployed to Hyperscaler and Persistent volume claim such as NFS , aur any Hyperscaler service could be used. By defining storage class.

 ## Learning Outcome

   1. Kubernetes - Deployments , Volume , PVC , minikube
   2. Model V2 of azure function app and azure container apps
   3. Cluster IP , Service in manifest file
   4. kompose tool
   5. Powershell Automation
 
