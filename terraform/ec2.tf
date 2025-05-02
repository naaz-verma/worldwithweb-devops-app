resource "aws_security_group" "worldwithweb-devops-app_sg" {
  name        = "${var.project}-sg"
  description = "Allow SSH and app access"
  
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




resource "aws_instance" "worldwithweb-devops-app_ec2" {
  ami             = var.ami_id # Amazon Linux 2 AMI 
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.worldwithweb-devops-app_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              docker pull ghcr.io/naaz-verma/worldwithweb-devops-app:latest
              docker run -d --name worldwithweb-devops-app -p 8000:8000 ghcr.io/naaz-verma/worldwithweb-devops-app:latest
              EOF

  tags = {
    Name = "${var.project}-instance"
  }
}
