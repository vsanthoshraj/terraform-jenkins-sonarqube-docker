# ============================================
# Root Module Outputs
# File: outputs.tf
# Purpose: Export important values
# ============================================

# ============================================
# VPC OUTPUTS
# ============================================

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

# Security Group Outputs
output "jenkins_security_group_id" {
  description = "Security group ID for Jenkins"
  value       = module.security_groups.jenkins_sg_id
}

output "sonarqube_security_group_id" {
  description = "Security group ID for SonarQube"
  value       = module.security_groups.sonarqube_sg_id
}

output "docker_security_group_id" {
  description = "Security group ID for Docker"
  value       = module.security_groups.docker_sg_id
}

# Key Pair Output
output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = module.keypair.key_pair_name
}

# Jenkins Instance Outputs
output "jenkins_instance_id" {
  description = "Instance ID of Jenkins server"
  value       = module.ec2.jenkins_instance_id
}

output "jenkins_private_ip" {
  description = "Private IP of Jenkins server"
  value       = module.ec2.jenkins_private_ip
}

output "jenkins_public_ip" {
  description = "Elastic IP of Jenkins server"
  value       = module.ec2.jenkins_public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = "http://${module.ec2.jenkins_public_ip}:8080"
}

# SonarQube Instance Outputs
output "sonarqube_instance_id" {
  description = "Instance ID of SonarQube server"
  value       = module.ec2.sonarqube_instance_id
}

output "sonarqube_private_ip" {
  description = "Private IP of SonarQube server"
  value       = module.ec2.sonarqube_private_ip
}

output "sonarqube_public_ip" {
  description = "Elastic IP of SonarQube server"
  value       = module.ec2.sonarqube_public_ip
}

output "sonarqube_url" {
  description = "URL to access SonarQube"
  value       = "http://${module.ec2.sonarqube_public_ip}:9000"
}

# Docker Instance Outputs
output "docker_instance_id" {
  description = "Instance ID of Docker builder"
  value       = module.ec2.docker_instance_id
}

output "docker_private_ip" {
  description = "Private IP of Docker builder"
  value       = module.ec2.docker_private_ip
}

output "docker_public_ip" {
  description = "Elastic IP of Docker builder"
  value       = module.ec2.docker_public_ip
}

# SSH Connection Commands
output "ssh_jenkins" {
  description = "SSH command for Jenkins"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${module.ec2.jenkins_public_ip}"
}

output "ssh_sonarqube" {
  description = "SSH command for SonarQube"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${module.ec2.sonarqube_public_ip}"
}

output "ssh_docker" {
  description = "SSH command for Docker"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${module.ec2.docker_public_ip}"
}

# Infrastructure Summary
output "infrastructure_summary" {
  description = "Summary of created infrastructure"
  value = {
    vpc = {
      id   = module.vpc.vpc_id
      cidr = module.vpc.vpc_cidr
    }
    instances = {
      jenkins = {
        id         = module.ec2.jenkins_instance_id
        private_ip = module.ec2.jenkins_private_ip
        public_ip  = module.ec2.jenkins_public_ip
        url        = "http://${module.ec2.jenkins_public_ip}:8080"
      }
      sonarqube = {
        id         = module.ec2.sonarqube_instance_id
        private_ip = module.ec2.sonarqube_private_ip
        public_ip  = module.ec2.sonarqube_public_ip
        url        = "http://${module.ec2.sonarqube_public_ip}:9000"
      }
      docker = {
        id         = module.ec2.docker_instance_id
        private_ip = module.ec2.docker_private_ip
        public_ip  = module.ec2.docker_public_ip
      }
    }
  }
}
