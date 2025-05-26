# worldwithweb-devops-app


A simple FastAPI app for DevOps hands-on demo.

```bash
#run locally
pip install -r requirements.txt
uvicorn main:app --reload


#run using docker
docker build -t worldwithweb-devops-app .
docker run -d -p 8000:8000 worldwithweb-devops-app
docker ps

#git connect
git init
git add .
git commit -m "Initial DevOps app commit"
git remote add origin https://github.com/naaz-verma/worldwithweb-devops-app.git
git branch -M main
git push -u origin main
git clone https://github.com/naaz-verma/worldwithweb-devops-app.git
git pull origin develop
git push origin develop
git push
git pull


#AWS hosting
 Create EC2 instance 
 Amazon Linux t2.micro OS and AMI
 Inbound Rules like this- 
 SSH	TCP	22	My IP or 0.0.0.0/0	(For SSH access)
 Custom TCP	TCP	8000	0.0.0.0/0	(To access your app)
 
 Create key value pair, download .pem file 
 
 Go to path of .pem file in terminal and run - 
 ssh -i path-to-your-key.pem ec2-user@<public-ip>
 
 
 # Install docker on Amazon Linux
 # Update packages
 sudo dnf update -y
 # Install Docker
 sudo dnf install docker -y
 # Start Docker
 sudo systemctl start docker
 # Enable Docker on boot (optional but recommended)
 sudo systemctl enable docker
 # Add your user to the docker group (to run docker without sudo)
 sudo usermod -aG docker ec2-user
 # Verify Docker works
 docker --version
 exit
 
 #Install git on Amazon Linux
 sudo yum install git -y
 git --version
 exit
 
 # Then reconnect via SSH
 
 git clone https://github.com/<your-username>/worldwithweb-devops-app.git
 cd worldwithweb-devops-app
 docker build -t worldwithweb-devops-app .
 docker run -d -p 8000:8000 worldwithweb-devops-app
  
 #Visit: http://<your-ec2-public-ip>:8000
 
 #Secrets required for CI/CD on Github Actions
 EC2_SSH_KEY	Paste full PEM content(RSA key)
 EC2_HOST	<your-ec2-public-ip>
 EC2_USER	ubuntu (or ec2-user if using Amazon Linux)
 
 #Copy key by opening in editor, will look like - 
 -----BEGIN RSA PRIVATE KEY-----
 ...
 -----END RSA PRIVATE KEY-----
 
 #Create secrets in Github 
 Settings -> secrets and variables -> Actions -> Repository Secrets
 
 #Upload docker image to ghcr
 make changes to the Ci/CD pipeline to push to ghcr
 Repo -> settings -> Actions -> general 
 Workflow permissions -> Check: Read and write permissions
 
 #Terraform 
 #folder for AWS infra
 #Create AWS access key and secret on console under IAM user
 #Add these to repo secrets 
 #terraform pipeline
 #Review the Plan to see the changes Terraform will make to your AWS environment.:
 terraform plan 
 
 #Apply the Configuration to provision the resources. Terraform will ask for confirmation before proceeding with the creation of resources:
 terraform apply 


#kubernetes 
install kubectl, minikube or docker desktop, helm 
Then either create k8s folder for self written kubernetes files or create using helm chart 
lens software

#k8s folder
minikube start
kubectl apply -f k8s/
kubectl get pods -A
kubectl describe pod <pod-name>
kubectl logs <pod-name>

#To access app
minikube service fastapi-service
or 
Docker Desktop:
Open http://localhost:30080 (NodePort)

#helm
helm install fastapi-app ./fastapi-chart
kubectl apply -f ./fastapi-chart
kubectl get pods
kubectl get svc
helm upgrade fastapi-app ./fastapi-chart


#branch jenkins-ansible to run and deploy the same app using jenkins and ansible

#Jenkins
run locally using docker, create Dockerfile.jenkins
docker build -t jenkins-docker -f Dockerfile.jenkins .
docker run -d --name jenkins -p 9090:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts
open localhost:9090

#to get initial admin passowrd 
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
In setup wizard, install suggested plugins and Set up your first admin user.
Configure the Jenkins URL (usually fine as default: http://localhost:8080 or http://localhost:9090).

#Connect GitHub Repo to Jenkins
A. Create a GitHub Personal Access Token (PAT)
Go to GitHub → Settings → Developer Settings → Personal Access Tokens → Tokens (classic).
Select scopes: repo(all under repo)
Copy the token 

B. Add the GitHub Token to Jenkins
Go to Jenkins → Manage Jenkins → Credentials → (global) → Add Credentials.
Select:
Kind: Username with password
Username: your GitHub username
Password: paste your GitHub token
ID: github-token (you’ll reference this in Jenkinsfile)
Save

#Create a Pipeline Job
A. Create a new job
From Jenkins Dashboard → New Item → Name it: worldwithweb-pipeline.
Choose: Pipeline → Click OK.

B. Configure the job
Under "Pipeline" section:
Definition: Pipeline script from SCM
SCM: Git
Repository URL: https://github.com/naaz-verma/worldwithweb-devops-app.git
Credentials: choose github-token
Branch: */jenkins-ansible
Script Path: Jenkinsfile (here in repo)
Save it 

#Add EC2 SSH Key in Jenkins
Go to Jenkins → Manage Jenkins → Credentials → (global) → Add Credentials.
Select:
Kind: SSH Username with private key
ID: ec2-ssh
Username: ec2-user
Private Key: Paste content of your .pem file
Save

Under pipeline name run using build now