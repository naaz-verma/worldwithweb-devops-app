# Define variables here if you want to make them configurable
variable "region" {
  description = "AWS region to deploy resources"
  type =  string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
