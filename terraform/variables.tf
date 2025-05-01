variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  description = "Your EC2 Key Pair name (must exist in AWS)"
  type        = string
}

variable "project" {
  default = "worldwithweb-devops-app"
}

variable "ami_id" {
  type = string
}
