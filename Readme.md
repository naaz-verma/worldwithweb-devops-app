# worldwithweb-devops-app
#branch created by naaz
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