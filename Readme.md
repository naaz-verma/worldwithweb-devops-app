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

#run terraform using
Initialize Terraform - to initialize the working directory containing Terraform configuration files:
terraform init 

Review the Plan to see the changes Terraform will make to your AWS environment.:
terraform plan 

Apply the Configuration to provision the resources. Terraform will ask for confirmation before proceeding with the creation of resources:
terraform apply 

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
EC2_SSH_KEY	Paste full PEM content
EC2_HOST	<your-ec2-public-ip>
EC2_USER	ubuntu (or ec2-user if using Amazon Linux)

#Copy key by opening in editor, will look like - 
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----

#Create secrets in Github 
Settings -> secrets and variables -> Actions -> Repository Secrets

