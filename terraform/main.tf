# Provider Configuration
provider "aws" {
  region = var.region  # Choose your AWS region
}

# Create a security group to allow access to the EC2 instance (port 22 for SSH and 8000 for the FastAPI app)
resource "aws_security_group" "allow_ssh_and_http" {
  name        = "allow_ssh_and_http"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance with the specified AMI and instance type
resource "aws_instance" "fastapi_instance" {
  ami           = var.ami_id  # Replace with the appropriate AMI ID (for example, an Ubuntu image)
  instance_type = "t2.micro"  # Instance type, can scale as needed
  key_name      = "your-ssh-key"  # Name of the SSH key for access

  security_groups = [aws_security_group.allow_ssh_and_http.name]

  # User data to install dependencies and start FastAPI app
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y python3-pip
              sudo apt install -y git
              git clone https://github.com/your/repo.git /home/ubuntu/fastapi-app
              cd /home/ubuntu/fastapi-app
              pip3 install -r requirements.txt
              nohup uvicorn main:app --host 0.0.0.0 --port 8000 &
              EOF

  tags = {
    Name = "FastAPIAppInstance"
  }
}

# Elastic IP (Optional, but useful for static IP assignment)
resource "aws_eip" "fastapi_eip" {
  instance = aws_instance.fastapi_instance.id
}
