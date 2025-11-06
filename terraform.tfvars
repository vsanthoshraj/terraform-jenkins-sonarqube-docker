
# Terraform Variables File
# File: terraform.tfvars
# Purpose: Set variable values

aws_region            = "us-east-1"
aws_profile           = "default"
environment           = "production"
project_name          = "cicd"
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidr    = "10.0.1.0/24"
availability_zone     = "us-east-1a"
instance_type         = "t3.small"
ssh_public_key_path   = "/home/ubuntu/.ssh/id_rsa.pub"
allowed_ssh_cidr      = ["0.0.0.0/0"]
jenkins_volume_size   = 50
sonarqube_volume_size = 40
docker_volume_size    = 40
