
# Root Module - Main Configuration
# File: main.tf
# Purpose: Call all child modules



# DATA SOURCES

# Get latest Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
}

# Key Pair Module
module "keypair" {
  source = "./modules/keypair"

  project_name        = var.project_name
  ssh_public_key_path = var.ssh_public_key_path
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security_groups"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  vpc_cidr          = var.vpc_cidr
  allowed_ssh_cidr  = var.allowed_ssh_cidr
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  project_name           = var.project_name
  environment            = var.environment
  ami_id                 = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  key_name               = module.keypair.key_pair_name
  
  jenkins_sg_id          = module.security_groups.jenkins_sg_id
  sonarqube_sg_id        = module.security_groups.sonarqube_sg_id
  docker_sg_id           = module.security_groups.docker_sg_id
  
  jenkins_volume_size    = var.jenkins_volume_size
  sonarqube_volume_size  = var.sonarqube_volume_size
  docker_volume_size     = var.docker_volume_size
}
