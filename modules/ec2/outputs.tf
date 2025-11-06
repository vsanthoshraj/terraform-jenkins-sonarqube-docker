# ============================================
# EC2 Module - Outputs
# File: modules/ec2/outputs.tf
# ============================================

# Jenkins Outputs
output "jenkins_instance_id" {
  description = "Instance ID of Jenkins"
  value       = aws_instance.jenkins.id
}

output "jenkins_private_ip" {
  description = "Private IP of Jenkins"
  value       = aws_instance.jenkins.private_ip
}

output "jenkins_public_ip" {
  description = "Public (Elastic) IP of Jenkins"
  value       = aws_eip.jenkins_eip.public_ip
}

# SonarQube Outputs
output "sonarqube_instance_id" {
  description = "Instance ID of SonarQube"
  value       = aws_instance.sonarqube.id
}

output "sonarqube_private_ip" {
  description = "Private IP of SonarQube"
  value       = aws_instance.sonarqube.private_ip
}

output "sonarqube_public_ip" {
  description = "Public (Elastic) IP of SonarQube"
  value       = aws_eip.sonarqube_eip.public_ip
}

# Docker Outputs
output "docker_instance_id" {
  description = "Instance ID of Docker"
  value       = aws_instance.docker.id
}

output "docker_private_ip" {
  description = "Private IP of Docker"
  value       = aws_instance.docker.private_ip
}

output "docker_public_ip" {
  description = "Public (Elastic) IP of Docker"
  value       = aws_eip.docker_eip.public_ip
}
