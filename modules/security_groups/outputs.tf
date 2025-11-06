# ============================================
# Security Groups Module - Outputs
# File: modules/security_groups/outputs.tf
# ============================================

output "jenkins_sg_id" {
  description = "Security group ID for Jenkins"
  value       = aws_security_group.jenkins_sg.id
}

output "sonarqube_sg_id" {
  description = "Security group ID for SonarQube"
  value       = aws_security_group.sonarqube_sg.id
}

output "docker_sg_id" {
  description = "Security group ID for Docker"
  value       = aws_security_group.docker_sg.id
}
